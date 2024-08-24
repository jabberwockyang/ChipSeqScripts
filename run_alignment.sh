#!/bin/bash
cd /root/chipseq
source /root/.conda/etc/profile.d/conda.sh
conda activate PeakCalling_analysis

# Define directories and parameters
FASTP_DIR="fastp"
BOWTIE2_INDEX="hg38-bowtie2/hg38-bowtie2"
OUTPUT_DIR="bowtie2_e2e"
THREADS=16

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR


# Loop over R1 files in the fastp directory
for R1_FILE in $FASTP_DIR/*_R1_filtered.fq.gz; do
    # Define corresponding R2 file
    R2_FILE="${R1_FILE/_R1_filtered.fq.gz/_R2_filtered.fq.gz}"
    
    # Extract sample name from the filename
    SAMPLE_NAME=$(basename $R1_FILE _R1_filtered.fq.gz)
    
    # Define output file paths
    SAM_FILE="$OUTPUT_DIR/${SAMPLE_NAME}_e2e.sam"
    BAM_FILE="$OUTPUT_DIR/${SAMPLE_NAME}_e2e.bam"
    SORTED_BAM_FILE="$OUTPUT_DIR/${SAMPLE_NAME}_e2e.sorted.bam"
    FLAGSTAT_FILE="$OUTPUT_DIR/${SAMPLE_NAME}_e2e.sorted.flagstat"
    LOG_FILE="$OUTPUT_DIR/${SAMPLE_NAME}_e2e.log"
    
    # Log start time
    echo "Alignment start time: $(date)" >> $LOG_FILE
    # Run Bowtie2
    bowtie2 -p $THREADS -q -x $BOWTIE2_INDEX -1 $R1_FILE -2 $R2_FILE -S $SAM_FILE 2> $LOG_FILE
    # Log end time
    echo "Alignment end time: $(date)" >> $LOG_FILE
    
    # Convert SAM to BAM
    samtools view $SAM_FILE -h -S -b -o $BAM_FILE -@ $THREADS
    
    # Delete SAM file to save space
    rm $SAM_FILE
    
    # Sort BAM file
    samtools sort $BAM_FILE -o $SORTED_BAM_FILE -@ $THREADS

    # Optional: remove intermediate BAM file to save space
    rm $BAM_FILE

    # Index sorted BAM file
    samtools index $SORTED_BAM_FILE -@ $THREADS
    
    # Generate flagstat report
    samtools flagstat $SORTED_BAM_FILE > $FLAGSTAT_FILE
    

done
