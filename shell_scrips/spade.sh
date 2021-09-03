#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N Spades_assembly
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory


# activating conda shell script on the terminal
. /shelf/apps/pjt6/conda/etc/profile.d/conda.sh 

# activate the unicycler virtual environment to run the spades py command.
conda activate spades

# set the directory to the directory holding the trimmed data
cd $HOME/Msc_Digital_Health/gd5302_genetics/

# make a directory to hold the result of the spades genome assembly technique for all patients
# if the directory already exists, don't mind
mkdir -p spades_result

# change the directory to spades_result
cd spades_result

# run spades on all the patients using a list of kmer values
# specifying kmer values from 41 to 81

# create a folder to store result for patient a, b, c and d

for paired_trimmed in ../trim_directory/*_1paired.fastq.gz
do

    # for each forward sequence get the base name of the file.
    # attach it to the reversed sequence. Example forward sequence (PA _1paired.fastq.gz), basename is PA, as _1paired.fastq.gz is ignored.
    reversed_paired=$(basename ${paired_trimmed} _1paired.fastq.gz)
    # -t 8 running 8 processes at once.
	
	# modified from: http://cab.spbu.ru/files/release3.12.0/manual.html#sec3.2
    spades.py --careful -t 8 \
    -1 ${paired_trimmed} -2 ../trim_directory/${reversed_paired}_2paired.fastq.gz \
    -o ${reversed_paired}

      
     wait
done
