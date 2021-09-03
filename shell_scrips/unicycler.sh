#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N Unicycler_Assembly
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory

# activating conda shell script on the terminal
. /shelf/apps/pjt6/conda/etc/profile.d/conda.sh 

# activate the unicycler virtual environment to run the unicycler py command.
conda activate unicyclerENV

# set the directory to the directory holding the trimmed data
cd $HOME/Msc_Digital_Health/gd5302_genetics/

# make a directory to hold the result of the unicycler genome assembly technique for all patients
# if the directory already exists, don't mind
mkdir -p unicycler_results

# change the current working directory to unicycler_results
cd unicycler_results

# run the unicycler assembly command on the paired trimmed results
# looping through the paired trimmed files as contained in the 

for paired_trimmed in ../trim_directory/*_1paired.fastq.gz
do
  # for each forward sequence get the base name of the file.
  # attach it to the reversed sequence. Example forward sequence (PA _1paired.fastq.gz), basename is PA, as _1paired.fastq.gz is ignored.
  reversed_paired=$(basename ${paired_trimmed} _1paired.fastq.gz)
  
  # modified from: https://github.com/rrwick/Unicycler
  unicycler -1 ${paired_trimmed} -2 ../trim_directory/${reversed_paired}_2paired.fastq.gz \
  -o ${reversed_paired} --keep 3 -t 8
  
  # hold on while the current task executes.
  wait
 
done

echo "Unicycler assembly was successfully carried out!"



