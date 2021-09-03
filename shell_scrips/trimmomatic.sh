#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N Trim_FastQC
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory


# set the directory to the directory holding the raw data
cd $HOME/Msc_Digital_Health/gd5302_genetics/

# create a new directory to store the trimmed files of the raw data
mkdir -p trim_directory
# hold on until the current task completes
wait

# current working directory is now changed.
cd trim_directory

# loop through all the forward genome sequences for each distinct patient.
for forward_sequence in ../raw_data/*_1.fastq.gz

do
  # for each forward sequence get the base name of the file.
  # attach it to the reversed sequence. Example forward sequence (PA _1.fastq.gz), basename is PA, as _1.fastq.gz is ignored.
  reversed=$(basename ${forward_sequence} _1.fastq.gz)
  # perform quality trim for the forward and reversed sequence
  # output both paired and unpaired trimmed sequences for forward and reversed genome
  # setting threads to 6 to allow 6 processes to be run once.
  # trim first trailing and leading genome sequences below quality score of 20
  # HEADCROP - cutting the first 15 base pairs
  # for every 4 reads, check trim any read below 20 quality score (SLIDINGWINDOW 4:20)
  
  # modified from: https://wikis.utexas.edu/display/bioiteam/Trimmomatic+-+GVA2020
  
  java -jar /shelf/training/Trimmomatic-0.38/trimmomatic-0.38.jar PE -summary ${reversed}_trim_summary.txt \
  ${forward_sequence} ../raw_data/${reversed}_2.fastq.gz \
  ${reversed}_1paired.fastq.gz ${reversed}_1unpaired.fastq.gz \
  ${reversed}_2paired.fastq.gz ${reversed}_2unpaired.fastq.gz \
  ILLUMINACLIP:/shelf/training/Trimmomatic-0.38/adapters/NexteraPE-PE.fa:2:40:15 \
  HEADCROP:15 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:40
done

# hold on while the previous task completes
wait

echo "Completed Trimming"
wait

# start quality check for the trimmed data extracted from the raw data.
echo "Starting quality check for trim files"

# create a folder to hold the quality check statistics for the trimmed data.
mkdir -p qc_trim_result
# Loading the fastqc module to access the quality of the file
echo "Loading the fastqc module"
module load FASTQC

# run the fastqc on the selected zipped file present in the path, where each file has an extension .fastq
# -o outputs the result of the fastqc to the created directory qc_trim_result.
# -t specifying thread to run files, 8 was selected to run 8 files at once.
# modified from: https://hbctraining.github.io/Intro-to-rnaseq-hpc-O2/lessons/02_assessing_quality.html

fastqc -o qc_trim_result -t 8 *paired.fastq.gz

# hold on while the previous task completes
wait
echo "Quality report was successfully generated. Task Done!"
