#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N Velvet_assembly
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory

# load the velvet module
module load velvet/gitv0_9adf09f

# set the directory to the directory holding the trimmed data
cd $HOME/Msc_Digital_Health/gd5302_genetics/

# make a directory to hold the result of the velvet genome assembly technique for all patients
# if the directory already exists, don't mind
mkdir -p velvet_results

# change the current working directory to velvet_results
cd velvet_results

# create a folder to store result for patient a, b, c and d
mkdir patient_A
mkdir patient_B
mkdir patient_C
mkdir patient_D


# run spades on all the patients using a list of kmer values
# specifying kmer values from 41 to 81
# increment in space of 4

for paired_trimmed in ../trim_directory/*_1paired.fastq.gz
do
  reversed_paired=$(basename ${paired_trimmed} _1paired.fastq.gz)
  cd ${reversed_paired}

  for ((c=41;c<=81;c+=4))
  do
    # modified from: https://angus.readthedocs.io/en/2016/week3/LN_assembly.html
	velveth K_${c} ${c} -fastq.gz -shortPaired ../${paired_trimmed} ../../trim_directory/${reversed_paired}_2paired.fastq.gz
	velvetg K_${c} -cov_cutoff auto
  
	# hold on while current process completes
	wait
  done
  
  # move backward
  cd ../
done
  
