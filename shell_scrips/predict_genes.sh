#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N Predict_Gene_Q3
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory
#$ -pe multi 8

# activating conda shell script on the terminal
. /shelf/apps/pjt6/conda/etc/profile.d/conda.sh 

# activate the unicycler virtual environment to run the proo py command.
conda activate prokka

#######################################################################################################
# predict gene using prokka
# modified from: https://metagenomics-workshop.readthedocs.io/en/2014-11-uppsala/functional-annotation/prokka.html
# predict gene for patient A to D using the best assembler based on N50 and L50 values
# result realised showed spade had best N50 and L50 value



#########################################################################################################################################
# set the directory to the directory holding the files
cd $HOME/Msc_Digital_Health/gd5302_genetics
for forward_sequence in raw_data/*_1.fastq.gz
do 
   # get the folder
   # we stored each folder as patient_A, patient_B, patient_C, and patient_D
   # this line extracts the basename as contained in the path. e.g patient_A _1.fastq.gz is extracted as patient_A which serves as a folder name created already.
   folder_name=$(basename ${forward_sequence} _1.fastq.gz)
   
   # change directory to the folder name, to allow us have access to other sub folders without stress.
   # get the quality assessment of all assembly -contigs.fa accross all the kmer values
   # -l creates a label for the kmer values
   # -t specifies the thread. running 8 processes at once.
   # -o outputs the result.
   export LC_ALL=C
   prokka --cpus 8 spades_result/${folder_name}/scaffolds.fasta --outdir predict_gene_${folder_name} --force
   wait

done
echo "we are done for spades"
