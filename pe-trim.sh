#!/bin/bash
#
# pe-trim.sh
# CHTC initial fastqc, trimming, and post-fastqc for paired end reads
# Usage: pe-trim.sh <samplename> <R1-fastq> <R2-fastq>

# mkdir
mkdir -p input output/initial_QC output/trimmed
export HOME=$PWD

# assign samplename to $1
# assign fastq1 to $2 and fastq2 to $3
samplename=$1
fastq1=$2
fastq2=$3

# copy reads1 and reads2 from staging to input directory
cp -r /staging/groups/roopra_group/jespina/$fastq1 input
cp -r /staging/groups/roopra_group/jespina/$fastq2 input

# print fastq filename
echo $fastq1 " and " $fastq2
echo "Running initial fastQC on " $samplename " (paired-end)"

# run initial fastqc
fastqc ~/input/$fastq1 ~/input/$fastq2 -o output/initial_QC 
multiqc -o output/initial_QC output/initial_QC

# trim illumina adapters
echo "Trimming " $samplename
trim_galore --paired --illumina --fastqc --cores 4 -o output/trimmed ~/input/$fastq1 ~/input/$fastq2  
multiqc -o output/trimmed output/trimmed

# tar output and copy to staging
tar -czvf ${samplename}_trimmed.tar.gz output/
mv ${samplename}_trimmed.tar.gz /staging/groups/roopra_group/jespina

# before script exits, remove files from working directory
rm -r input output

###END
