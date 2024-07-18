#Pathogenic variants

for i in *.vcf
do
sampleid=$(echo $i | cut -d '_' -f1)
grep -o "CLNSIG=[^;]*" $i > ${sampleid}_temp
grep -wv "CLNSIG=." ${sampleid}_temp > ${sampleid}_clinsig
done
rm *temp

for i in *clinsig
do
sampleid=$(echo $i | cut -d '_' -f1)
grep -i "pathogenic" $i | grep -vi "conflicting" > ${sampleid}_pathogenics
less ${sampleid}_pathogenics | wc -l > ${sampleid}_PLP_count
done
rm *_pathogenics

for i in *_count
do
echo $i | cut -d '_' -f1 >> sampleids
cat $i >> counts
paste  sampleids counts > pathogenic_info
done

for vcf_file in *.vcf; do
    sampleid=$(echo "$vcf_file" | cut -d '_' -f1)
    grep -o "CLNSIG=[^;]*" "$vcf_file" > "${sampleid}_temp"
    grep -wv "CLNSIG=." "${sampleid}_temp" > "${sampleid}_clinsig"
    rm "${sampleid}_temp"

    grep -i "pathogenic" "${sampleid}_clinsig" | grep -vi "conflicting" > "${sampleid}_pathogenics"
    wc -l < "${sampleid}_pathogenics" > "${sampleid}_PLP_count"
    rm "${sampleid}_pathogenics"
done

for count_file in *_PLP_count; do
    echo "$(echo "$count_file" | cut -d '_' -f1)" >> sampleids
    cat "$count_file" >> counts
done
paste sampleids counts > pathogenic_info

rm sampleids counts *PLP_count *clinsig
