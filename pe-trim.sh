#!/bin/bash
#
# pe-trim.sh
# CHTC initial fastqc, trimming, and post-fastqc for paired end reads
# Usage: pe-trim.sh <R1-fastq> <R2-fastq>

# mkdir
mkdir input output

# assign fq_1 to $1 and fq_2 to $2
fq_1=$1
fq_2=$2

# grab base filename for naming outputs
base=`basename $fq_1 _R1_001.fastq.gz`

# copy reads1 and reads2 from staging to input directory
cp -r /staging/groups/roopra_group/jespina/$fq_1 /staging/groups/roopra_group/jespina/$fq_2 input

# print fastq filename
echo $fq_1 "and" $fq_2
echo "Running fastQC"

# run initial fastqc
fastqc input/$fq_1 input/$fq_2 -o output 

# trim illumina adapters
echo "Trimming"
trim_galore --paired --illumina --fastqc -o output input/$fq_1 input/$fq_2  

# tar output and copy to staging
tar -czvf ${base}_fastqc.tar.gz output/
mv ${base}_fastqc.tar.gz /staging/groups/roopra_group/jespina

# before script exits, remove files from working directory
rm -r input
rm -r output

###END
