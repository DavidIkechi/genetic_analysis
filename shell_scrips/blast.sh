#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N blast
#$ -S /bin/bash ## shell where it will run this job
#$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory
#$ -pe multi 8

# set the directory to the directory holding the trimmed data
cd $HOME/Msc_Digital_Health/gd5302_genetics
mkdir -p results
# this is where the nr nt diamond db are
export BLASTDB=/shelf/public/blastntnr/blastDatabases

# latest version of blast - this will now be in your path
export PATH=/shelf/apps/ncbi-blast-2.7.1+/bin/:$PATH

#lets analyse the first six lines of our best assembles.
# for patient A
head -10 spades_result/patient_A/scaffolds.fasta > first_10_lines_a.txt
# for patient B
head -10 spades_result/patient_B/scaffolds.fasta > first_10_lines_b.txt
# for patient C
head -10 spades_result/patient_C/scaffolds.fasta > first_10_lines_c.txt
# for patient D
head -10 spades_result/patient_D/scaffolds.fasta > first_10_lines_d.txt


#lets blast all the results, in tabular output
# for patient A 
blastn -task megablast -query first_10_lines_a.txt -db nt -outfmt \
'6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' \
-evalue 1e-20 -out results/n.first_10_lines_a.txt_versus_ntOutfmt6.out -num_threads 8

# for patient B 
blastn -task megablast -query first_10_lines_b.txt -db nt -outfmt \
'6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' \
-evalue 1e-20 -out results/n.first_10_lines_b.txt_versus_ntOutfmt6.out -num_threads 8

# for patient C 
blastn -task megablast -query first_10_lines_c.txt -db nt -outfmt \
'6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' \
-evalue 1e-20 -out results/n.first_10_lines_c.txt_versus_ntOutfmt6.out -num_threads 8

# for patient D 
blastn -task megablast -query first_10_lines_d.txt -db nt -outfmt \
'6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' \
-evalue 1e-20 -out results/n.first_10_lines_d.txt_versus_ntOutfmt6.out -num_threads 8

echo "we have blasted"