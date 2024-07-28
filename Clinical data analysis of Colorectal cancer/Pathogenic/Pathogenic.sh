#Pathogenic variants
#!/bin/bash
for i in *.vcf
do
sampleid=$(echo $i | cut -d '_' -f1)
grep -i "pathogenic" $i | grep -vi "conflicting" > ${sampleid}_pathogenics
less ${sampleid}_pathogenics | wc -l > ${sampleid}_PLP_count
done

for count_file in *_PLP_count; do
    echo "$(echo "$count_file" | cut -d '_' -f1)" >> sampleids
    cat "$count_file" >> counts
done
paste sampleids counts > pathogenic_info

rm sampleids counts *PLP_count 
