# DNA Sequencing Analysis
This report aims to identify an unknown sample present in a patient's genome sequence using DNA sequencing techniques. The dataset used in this analysis consists of genome sequences from four patients: A, B, C, and D. The raw patient data was obtained from the University of St-Andrews Marvin server, as supplied by Dr. Peter Thorpe. The analysis of these data will help identify the organism contained in each patient sequence data and assist clinicians in disease diagnosis and decision-making.

## Dataset
The dataset used in this analysis includes the genome sequences of patients A, B, C, and D. These sequences were obtained from the University of St-Andrews Marvin server and provided by Dr. Peter Thorpe. The dataset serves as the input for the various processes performed in the analysis.

### Analysis Process
The analysis of the DNA sequencing data involved several processes to ensure accurate and reliable genome analysis. The following processes were performed:

- Data Cleaning: The raw patient data was processed to eliminate errors and artefacts that could potentially affect the accuracy of the genome analysis. This step aimed to ensure the integrity of the sequencing data.

- Genome Assembly: Genome assembly software was employed to reconstruct the patient genome sequences from the raw sequencing reads. This process involved aligning and overlapping the reads to generate contiguous sequences representing the patient's genome.

- Software Utilization: Shell scripting was used to access the genome assembly software in a non-interaction mode. This allowed for efficient and automated execution of the software packages, ensuring consistency in the analysis.

- Genome Analysis: Python scripting was utilized to perform various calculations and analyses on the obtained genome sequences. This step aimed to extract meaningful information from the genome data and identify the organism present in each patient sequence.

# Languages and Libraries Used
The analysis process was implemented using the following languages and libraries:

- Python: Python was the primary language used for the genome analysis, data processing, and scripting tasks.
- Shell Scripting: Shell scripting was employed to access the genome assembly software in a non-interaction mode.

The following libraries were utilized in the Python scripts:

- NumPy: NumPy was used for efficient numerical computations and data manipulation.
- Pandas: Pandas was utilized for data preprocessing and analysis, such as FASTA data etc.
- BioPython: BioPython provided functionality for working with biological sequences and performing sequence analysis tasks.
- Other Relevant Libraries: Additional libraries such as matplotlib, seaborn, or scikit-learn may have been used for data visualization, statistical analysis, or machine learning, depending on the specific requirements of the analysis.

# Running the Analysis
To replicate or further explore the analysis process, please follow these steps:

- Obtain the raw patient data from the University of St-Andrews Marvin server or a relevant source.
- Preprocess the data by performing data cleaning techniques to eliminate errors and artefacts. FastQC was used to access the quality of the reads, while trimmomatic was used to eliminate errors and artefacts (reads with low quality scores).
- Employ genome assembly software of choice to reconstruct the patient genome sequences.
All these were done using shell-scripted codes as identified in the shell_scripts folder.

Implement Python scripts using the aforementioned libraries to perform calculations and analyses on the obtained genome sequences.
- Customize the analysis as needed, adjusting parameters and algorithms based on specific requirements.
- Evaluate the results and draw conclusions based on the identified organisms present in each patient sequence. The assembled genome sequences were analyzed to identify the organisms present using BLASTN.

Please refer to the provided scripts, comments, and pdf for detailed instructions on each step of the analysis process. Feel free to adapt the code and processes to suit your specific dataset and analysis goals.


