#Preprocessing maf files, add tumor sample id and concatenate into single maf file which is needed in further steps
#!/bin/bash
for i in *.maf
do
id=$(echo $i | cut -d "_" -f1)
sed "s/TUMOR/TUMOR_${id}/g" $i > ${id}_sample.maf
tail -n +3 ${id}_sample.maf > ${id}_wh.maf
head -n +2 $i | tail -n +2 > header.maf
done

cat header.maf *wh.maf > Alltumor.maf

rm *wh.maf header.maf

#A. Pathogenic/Likely pathogenic information from vcf file
#!/bin/bash

for vcf_file in *.vcf; do
    sampleid=$(echo "$vcf_file" | cut -d '_' -f1)
    grep -i "pathogenic" "$vcf_file" | grep -vi "conflicting" > "${sampleid}_pathogenics"
    wc -l < "${sampleid}_pathogenics" > "${sampleid}_PLP_count"

done

for count_file in *_PLP_count; do
    echo "$(echo "$count_file" | cut -d '_' -f1)" >> sampleids
    cat "$count_file" >> counts
done
paste sampleids counts > pathogenic_info


rm sampleids counts *PLP_count

#Place "pathogenics" and maf files within the same directory to extract the mutated gene information
#!/bin/bash

for columns_file in *pathogenics;do
        sampleids=$(echo "$columns_file" | cut -d '_' -f1)
        awk '{print $1,$2,$3,$4,$5}' $columns_file > ${sampleids}_vcf_columns
        awk '{print $2}' $columns_file > ${sampleids}_vcfposition
                while read position;do
                        grep $position ${sampleids}_sample.maf | awk '{print $1,$9,$12,$13,$14,$15,$19,$20}' > ${sampleids}_maf_pos_genes
                        done < ${sampleids}_vcfposition
paste ${sampleids}_vcf_columns ${sampleids}_maf_pos_genes > ${sampleids}_pathogenic_data
done

rm *vcf_columns *vcfposition *maf_pos_genes

#B. Tumor Mutational burden

#!/bin/bash
#PG

for i in *.maf
do
sampleid=$(echo $i | cut -d '_' -f1)
echo $sampleid >> sampleidz
exomesize=37

awk '{print $9}' $i | grep -E -wc "3'UTR|5'UTR|3'Flank|5'Flank|Frame_Shift_Del|Frame_Shift_Ins|IGR|In_Frame_Ins|In_Frame_Del|Intron|Missense_Mutation|Nonsense_Mutation|Nonstop_Mutati>
awk "{print \$1/37}" ${sampleid}_nonsyn_count >> nonsyn_tmb


awk '{print $9}' $i | grep -E -wc "Silent" > ${sampleid}_syn_count
awk "{print \$1/37}" ${sampleid}_syn_count >> syn_tmb


awk '{print $9}' $i | grep -E -wc "3'UTR|5'UTR|3'Flank|5'Flank|Frame_Shift_Del|Frame_Shift_Ins|IGR|In_Frame_Ins|In_Frame_Del|Intron|Missense_Mutation|Nonsense_Mutation|Nonstop_Mutati>
awk "{print \$1/37}" ${sampleid}_nonsyn_count >> total_tmb

paste sampleidz nonsyn_tmb syn_tmb total_tmb > samplewise_total_tmb

done

rm nonsyn_tmb syn_tmb *_count sampleidz

#C. Oncogenes and Tumor suppressor genes mapping
#Obtain FDA approved cancer related genes from OncoKB and prepare list of oncogenes and tumour suppressor genes as annotated
#!/bin/bash
for file in *.maf
do
id=$(echo $file | cut -d '_' -f1)
awk '{print $1}' $file > ${id}_mutgenes
comm -12 <(sort ${id}_mutgenes) <(sort bothOGTSG)> ${id}_both.txt
comm -12 <(sort ${id}_mutgenes) <(sort tsg)> ${id}_tsg.txt
comm -12 <(sort ${id}_mutgenes) <(sort og)> ${id}_og.txt
comm -12 <(sort ${id}_mutgenes) <(sort neither)> ${id}_pathgenes.txt
done

output_file="cancergenes_distribution.tsv"

echo -e "Sample\tBoth\tPathGenes\tOG\tTSG\tTotalMutations" > "$output_file"

for file in "$input_dir"/*_both.txt; do
    sample_name=$(basename "$file" | cut -d'_' -f1)
    both_count=$(wc -l < "$file")
    pathgenes_count=$(wc -l < "$input_dir/${sample_name}_pathgenes.txt")
    og_count=$(wc -l < "$input_dir/${sample_name}_og.txt")
    tsg_count=$(wc -l < "$input_dir/${sample_name}_tsg.txt")
    total_count=$(wc -l < "$input_dir/${sample_name}_mutgenes")

    echo -e "$sample_name\t$both_count\t$pathgenes_count\t$og_count\t$tsg_count\t$total_count" >> "$output_file"
done


paste -d$'\t' *_og.txt > ogsz
paste -d$'\t' *_tsg.txt > tsgz
paste -d$'\t' *_both.txt > bothsz
paste -d$'\t' *_pathgenes.txt > pathgenesz
