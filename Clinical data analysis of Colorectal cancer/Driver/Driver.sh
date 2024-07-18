#D. Driver gene distribution
# Obtain list of driver genes in CRC from IntOgen <saved as driver_gene_list>
#Extracting known driver genes

for i in *.maf
do
sampleid=$(echo $i | cut -d '_' -f1)
tail -n +3 $i | awk '{print $1}' > ${sampleid}_mutated_genes
comm -12 <(sort ${sampleid}_mutated_genes) <(sort driver_gene_list) > ${sampleid}_drivergenes
done
