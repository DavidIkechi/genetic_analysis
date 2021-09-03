#!/bin/bash
#$ -V ## VERY IMPORTANT
#$ -N FastQC_raw_Data_Q1 ## This is the name of the raw_data
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory
#$ -pe multi 16


# set the directory to the directory holding the fastq file.
cd $HOME/Msc_Digital_Health/gd5302_genetics/

# make a directory to store the quality score of the fasta files
# only create this directory if it doesnt exist

mkdir -p patients_qc_result

# Loading the fastqc module to access the quality of the file
echo "Loading the fastqc module"
module load FASTQC

# run the fastqc on the selected zipped file present in the path, where each file has an extension .fastq
# the raw_data directory contains untrimmed files, copied from the coursework read directory.
# -o outputs the result of the fastqc to the created directory patients_qc_result
# -t specifying thread to run files, 8 was selected to run 8 files at once.
# modified from: https://hbctraining.github.io/Intro-to-rnaseq-hpc-O2/lessons/02_assessing_quality.html

fastqc -o patients_qc_result -t 8 raw_data/*.fastq.gz # run the fastqc on all fastq files as contained in the raw_data directory.

# hold on while the previous task completes
wait
echo "Quality report was successfully generated. Task Done!"
