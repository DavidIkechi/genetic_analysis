#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N Quast_Velvet
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory

# set the directory to the directory holding the trimmed data
cd $HOME/Msc_Digital_Health/gd5302_genetics/velvet_results/


# check the quality assessment assembly result for all the patients
# we do this by comparing different kmer values to get the best 
# by the best we compare the N50 and L50 values accross all the kmer values

#lets do for patient A
for forward_sequence in ../raw_data/*_1.fastq.gz
do 
   # get the folder
   # we stored each folder as patient_A, patient_B, patient_C, and patient_D
   # this line extracts the basename as contained in the path. e.g patient_A _1.fastq.gz is extracted as patient_A which serves as a folder name created already.
   folder_name=$(basename ${forward_sequence} _1.fastq.gz)
   
   # change directory to the folder name, to allow us have access to other sub folders without stress.
   cd ${folder_name}
   # get the quality assessment of all assembly -contigs.fa accross all the kmer values (41,51,61,71 and 81)
   # -l creates a label for the kmer values
   # -t specifies the thread. running 8 processes at once.
   # -o outputs the result.
   
   # modified from: http://quast.sourceforge.net/docs/manual.html#sec2.3
   quast.py -t 8 K_41/contigs.fa K_45/contigs.fa K_49/contigs.fa K_53/contigs.fa \
     K_57/contigs.fa K_61/contigs.fa K_65/contigs.fa K_69/contigs.fa \
	 K_73/contigs.fa K_77/contigs.fa K_81/contigs.fa \
	 -l "k-41","k-45","k-47","k-53","k-57","k-61","k-65","k-69","k-73","k-77","k-81" \
	 -o quast_result_${folder_name}
   wait
   
   # move back to velvet_results/ folder
   cd ../

done

echo "we are done"