#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N best_assembly
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory
#$ -pe multi 8

# set the directory to the directory holding the trimmed data
cd $HOME/Msc_Digital_Health/gd5302_genetics


# check the quality assessment assembly result for all the patients
# we do this by comparing different kmer values to get the best 
# by the best we compare the N50 and L50 values accross all the kmer values

#lets do for patient A
for forward_sequence in raw_data/*_1.fastq.gz
do 
   # get the folder
   # we stored each folder as patient_A, patient_B, patient_C, and patient_D
   # this line extracts the basename as contained in the path. e.g patient_A _1.fastq.gz is extracted as patient_A which serves as a folder name created already.
   folder_name=$(basename ${forward_sequence} _1.fastq.gz)
   
   
   # get the quality assessment of all assembly -contigs.fa accross all the kmer values (41,51,61,71 and 81)
   # -l creates a label for the kmer values
   # -t specifies the thread. running 8 processes at once.
   # -o outputs the result.
   
   # modified from: http://quast.sourceforge.net/docs/manual.html#sec2.3
   if [ $folder_name == "patient_A" ];
   then
	 quast.py -t 8 velvet_results/${folder_name}/K_65/contigs.fa spades_result/${folder_name}/scaffolds.fasta \
	 unicycler_results/${folder_name}/assembly.fasta \
	 -l "Velvet","Spades","Unicycler" -o best_assembly_${folder_name}
     wait
	 
   elif [ $folder_name == "patient_B" ]; 
   then 
	 quast.py -t 8 velvet_results/${folder_name}/K_45/contigs.fa spades_result/${folder_name}/scaffolds.fasta \
	 unicycler_results/${folder_name}/assembly.fasta \
	 -l "Velvet","Spades","Unicycler" -o best_assembly_${folder_name}
     wait
   elif [ $folder_name == "patient_C" ];
   then 
	 quast.py -t 8 velvet_results/${folder_name}/K_77/contigs.fa spades_result/${folder_name}/scaffolds.fasta \
	 unicycler_results/${folder_name}/assembly.fasta \
	 -l "Velvet","Spades","Unicycler" -o best_assembly_${folder_name}
     wait
   elif [ $folder_name == "patient_D" ]; 
   then 
	 quast.py -t 8 velvet_results/${folder_name}/K_81/contigs.fa spades_result/${folder_name}/scaffolds.fasta \
	 unicycler_results/${folder_name}/assembly.fasta \
	 -l "Velvet","Spades","Unicycler" -o best_assembly_${folder_name}
     wait
   fi	  
done

echo "we are done"
