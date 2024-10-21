#!/bin/bash
#
# fastqc-test.sh
# CHTC fastqc job test

# mkdir
mkdir input output

# assign fastq to $1
fastq=$1

# grab base filename for naming outputs
base = `basename $fastq .fastq.gz`

# copy $fastq from staging to input directory
cp -r /staging/groups/roopra_group/jespina/$fastq input

# print fastq filename
echo $fastq
echo "Running fastQC"

# run initial fastqc
fastqc input/$fastq -o output 

# tar output and copy to staging
tar -czvf $base_fastqc_output.tar.gz output/
mv $base_fastqc_output.tar.gz /staging/groups/roopra_group/jespina

# before script exits, remove files from working directory
rm -r input
rm -r output

###END
