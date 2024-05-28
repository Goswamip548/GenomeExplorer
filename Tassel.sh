#Prerequisite:
 
#TASSEL
 
#Keyfile having information about barcodes. Single file for each sample
#1. Concatenating the paired end reads into a single file
#Concatenate to merge the files. The bash script concatenate.sh was used to automate the process for all the files. The raw files were named as S1_1.fq S1_2.fq.

#!/bin/bash/ START = 1
END = 121
for ((i=$START; i<=$END; i++))
do
cat S"$i"_1.fq S"$i"_2.fq > S"$i"_comb.fq done
echo "done"

#we can execute the script using ./concatenate.sh on terminal
#move the concatenated files to Scomb

mv *_comb.fq ~/Var_call/data/Scomb


#2.Adding Barcodes
#Using the R script documented by Labroo, we add fake barcodes to run on tassel pipeline. The read length is obtained from QC summary. A Keyfile is generated- keyfile.txt.
barcode_fake(fastq_dir = “home/Var_call/data/Scomb/”, read_length =150)


#3.Commands to run tassel pluins on terminal
1.	./run_pipeline.pl -Xms100g -Xmx180g -GBSSeqToTagDBPlugin -e MseI -i /home/.../tassel-5- standalone/Scomb/ -db /home/.../GBSv2.db -k /home/.../fakebarcode_key.txt -kmerLength 64 - mnQS 20 - c 5 -endPlugin

#The output for this step is GBSV2.db database file.
2.	./run_pipeline.pl -Xms100g -Xmx180g -TagExportToFastqPlugin -db /home/../GBSv2.db -o
/home/../tassel-5-standalone/tempdir/tagsForAlign.fa.gz -endPlugin

#The output form this step is tagsForAlign.fa.gz file (compressed fasta file). Alignment was done using BWA then.
 
##################################################################################
BWA ALIGNMENT.sh
#!/bin/bash genome=~/Var_call/data/ref_genome/safflower.fasta bwa index $genome

for i in ~/Var_call/data/Scomb /*_comb.fastq do
base=$(basename S${i} _comb.fa) i=~/Var_call/data/Scomb/${base}_comb.fastq sam=~/gatk/samfiles/${base}.sam
bwa mem $genome $i > $sam
done


#####################################################################################
3.	./run_pipeline.pl -Xms100g -Xmx180g -SAMToGBSdbPlugin -i /home/.../tassel-5- standalone/tagsForAlign.sam -db /home/.../GBSv2.db -endPlugin
#This step will not generate any output, but you will notice the database (GBSV2.db) has been modified.
4.	./run_pipeline.pl -Xms100g -Xmx180g -DiscoverySNPCallerPluginV2 -db /home/../GBSv2.db -sC 1 - eC 121 -mnMAF 0.01 -endPlugin
#change the -sC and -eC for start and end sample files for which you need stats for This step will not generate any output, but you will notice the database (GBSV2.db) has been modified.
5.	./run_pipeline.pl -Xms100g -Xmx180g -SNPQualityProfilerPlugin -db /home/../GBSv2.db -taxa
/home/../tassel-5-standalone/IBMGBSTaxaList.txt -tname “IBM” -statFile /home/../tassel-5- standalone/tempDir/SNPQualityStatsIBM.txt -endPlugin
#(this is via using subset of indivuals)
./run_pipeline.pl -Xms100g -Xmx180g -SNPQualityProfilerPlugin -db /home/../GBSv2.db - statFile
/home/../tempDir/SNPQualityStatsIBM.txt -endPlugin
#(this is via using all indivuals)
#Output for this step is the file **_Stats_.txt** with SNP statistics
 
6.	./run_pipeline.pl -Xms100g -Xmx180g -UpdateSNPPositionQualityPlugin -db /home/../GBSv2.db qsFile /home/../tassel-5-standalone/SNPQualityScoresAll.txt -endPlugin
#updates the SNP position quality.
7.	./run_pipeline.pl -Xms100g -Xmx180g -ProductionSNPCallerPluginV2 -db /home/../GBSv2.db -e MseI -i /home/../tassel-5-standalone/fastqfolder/ -k /home/../tassel-5- standalone/fakebarcodes_key.txt -kmerLength 64 -minPosQS1 -o /home/../tasssel 5- standalone/tempDir/safTestGBSGenosMinQ1.h5 -endPlugin
#The final file tassel-gbs.vcf and tassel-gbs.h5 are the genotypes in VCF and HDF5 format. -GBSv2.db is modified multiple times. While providing input, we have to provide proper directory for unmodified file to be recognised.
