#Tumor Mutational burden
#!/bin/bash
for i in *.maf
do
sampleid=$(echo $i | cut -d '_' -f1)
echo $sampleid >> sampleids
exomesize=37

awk '{print $9}' $i | grep -E -wc "3'UTR|5'UTR|3'Flank|5'Flank|Frame_Shift_Del|Frame_Shift_Ins|IGR|In_Frame_Ins|In_Frame_Del|Intron|Missense_Mutation|Nonsense_Mutation|Nonstop_Mutation|RNA|Splice_Region|Splice_Site|Translation_Start_Site" > ${sampleid}_nonsyn_count
awk "{print \$1/37}" ${sampleid}_nonsyn_count >> nonsyn_tmb 
paste sampleids nonsyn_tmb > samplewise_nonsyn_tmb

awk '{print $9}' $i | grep -E -wc "Silent" > ${sampleid}_syn_count
awk "{print \$1/37}" ${sampleid}_syn_count >> syn_tmb
paste sampleids syn_tmb > samplewise_syn_tmb
done
