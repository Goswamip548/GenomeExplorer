#Pathogenic variants
#!/bin/bash
for i in *.vcf
do
sampleid=$(echo $i | cut -d '_' -f1)
grep -i "pathogenic" $i | grep -vi "conflicting" > ${sampleid}_pathogenics
less ${sampleid}_pathogenics | wc -l > ${sampleid}_PLP_count
done

#Tabulated form to count samplewise pathogenic variants
for count_file in *_PLP_count; do
    echo "$(echo "$count_file" | cut -d '_' -f1)" >> sampleids
    cat "$count_file" >> counts
done
paste sampleids counts > pathogenic_info

rm sampleids counts *PLP_count 

#Place "pathogenics" and maf files within the same directory to extract the mutated gene information
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
