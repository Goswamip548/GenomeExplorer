#1. Unzipping rawfiles
#!/bin/bash
cd ~/trancriptome/data/rawdata for rawreads in *.zip
do
unzip $rawreads done
#this will unzip all the raw zipped files in the working directory and can be executed by bash unziiping,sh
on terminal
#2. Quality check
#!/bin/bash
#Changing the directory to untrimmed_fastq/
set -e
cd ~/transcriptome/data/untrimmed_fastq/
#Run FastQC on all the files in our current directory
echo “Running FastQC …”
~/FastQC/fastqc *.fastq
#Make a new directory to store our results
 
mkdir -p ~/transcriptome/results/fastqc_untrimmed_reads #Results of the QC will be moved to fastqc_untrimmed_reads echo “Saving FastQC results …”
mv *.zip ~/transcriptome/results/fastqc_untrimmed_reads mv *.html ~/transcriptome/results/fastqc_untrimmed_reads #Unzip the results.
cd ~/transcriptome/results/fastqc_untrimmed_reads echo “Unzipping…”
for filename in *.zip do
unzip $filename done
#Obtain the quality check summary
echo “Saving summary…”
cat */summary.txt > ~/transcriptome/docs/fastqc_summaries.txt
#####################################################################################
#On the Terminal prompt we can now run this bash script and get automated QC report of our four files.
bash seq_QC.sh
Using this we automated our analysis for all our samples. There was adapter contamination in the sequences.



#3. Trimming reads by trimmomatic
#Here is an automated bash script for running trimmomatic on all our files getting the paired and unpaired output for our paired end reads
for infile in *_1.fastq.gz do
 


done
 
base=$(basename ${infile} _1.fastq.gz) trimmomatic PE ${infile} ${base}_2.fastq.gz \
${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz \
${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz \
SLIDINGWINDOW:3:20 MINLEN:50 ILLUMINACLIP:TruSeq3-PE.fa:2:30:10
 
#Re-run the FastQC to check. All the adaptor contamination were successfully removed in our case.
#4. Aligning our reads

#forward strands pooled by catenation
cat Rep1ny_1.trim.fastq.gz Rep2ny_1.trim.fastq.gz Rep3ny_1.trim.fastq.gz > ny_1.trim.fastq.gz
cat Rep1ny_2.trim.fastq.gz Rep2ny_2.trim.fastq.gz Rep3ny_2.trim.fastq.gz
>ny_2.trim.fastq.gz

#Pooling the samples by catenating the replicates of nymph and adult
cat Rep1ny_1.trim.fastq.gz Rep2ny_1.trim.fastq.gz Rep3ny_1.trim.fastq.gz Rep1ny_2.trim.fastq.gz Rep2ny_2.trim.fastq.gz Rep3ny_2.trim.fastq.gz Rep1ad_1.trim.fastq.gz Rep2ad_1.trim.fastq.gz Rep3ad_1.trim.fastq.gz Rep1ad_2.trim.fastq.gz Rep2ad_2.trim.fastq.gz Rep3ad_2.trim.fastq.gz >
AdNyAsspool.fasta.gz

#Unzipped first, and aligned with trinity.An output file-Trinity.fasta will be obtained
$ Trinity --seqType fq --left '/home/…/TRIMMEDDATA/ny_1.trim.fastq' --right '/home/…/TRIMMEDDATA/ny_2.trim.fastq' --CPU 12 --max_memory 8G

#gives us the stats for our alignment:
$TrinityStats.pl '/home/…/trinityLeAd/Trinity.fasta' >& stats.log


#5. Clustering was done using cdhit-est to find unigenes #Trinity.fasta obtained by assembly of all adult and nymph replicates
cdhit-est -i '/home/…/Transcriptome_Data/Trinity.fasta' -o clusterAdNy.fasta -c 0.80 -M 20000
#6. Quantification using kallisto
kallisto index -i clusterAdNy.index '/home/…/Transcriptome_Data/cdhit- est/clusterAdNy.fasta' --make-unique

kallisto quant -i clusterLeAdNy.index -o Rep1Ny_1_kallisto -b 100 -t 8 '/home/…/Transcriptome_Data/Rep1ny_1.trim.fastq.gz' '/home/…/Transcriptome_Data/Rep1ny_2.trim.fastq.gz'

#7. Primary Annotation using Blast+ toolkit
#to get swissprot database
 
wget https://ftp.ncbi.nlm.nih.gov/blast/db/swissprot.tar.gz tar xvzf swissprot.tar.gz

#running Blast+
>blast+
./blastp -db swissprot -query sequence.fasta -out output.out
