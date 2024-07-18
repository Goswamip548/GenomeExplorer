#common gene finder script between known cancer genes and genes mutated in our sample 

for i in *mutgenes
do
sampleid=$(echo $i | cut -d '_' -f1)
comm -12 <(sort $i) <(sort bothOGTSG)> ${sampleid}_both.txt
comm -12 <(sort $i) <(sort tsg)> ${sampleid}_tsg.txt
comm -12 <(sort $i) <(sort og)> ${sampleid}_og.txt
comm -12 <(sort $i) <(sort neither)> ${sampleid}_pathgenes.txt
done
