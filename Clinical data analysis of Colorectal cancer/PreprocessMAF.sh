#!/bin/bash
#Preprocessing maf files, add tumor sample id and concatenate into single maf file which is needed in further steps
for i in *.maf
do
id=$(echo $i | cut -d "_" -f1)
sed "s/TUMOR/TUMOR_${id}/g" $i > ${id}_sample.maf
tail -n +3 ${id}_sample.maf > ${id}_wh.maf
head -n +2 $i | tail -n +2 > header.maf
done

cat header.maf *wh.maf > Alltumor.maf

rm *wh.maf header.maf
