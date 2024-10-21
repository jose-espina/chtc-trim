#!/bin/bash
#
# fastqc-test.sh
# CHTC fastqc job test

# mkdir
mkdir input output

# assign filename to $1
filename=$1

# copy $filename from staging to input directory
cp -r /staging/groups/roopra_group/jespina/$filename input

# print fastq filename
echo $filename
echo "Running fastQC"

# run initial fastqc
fastqc input/$filename -o output 

# tar output and copy to staging
tar -czvf $1_fastqc_output.tar.gz output/
mv $1_fastqc_output.tar.gz /staging/groups/roopra_group/jespina

# before script exits, remove files from working directory
rm -r input
rm -r output

###END
