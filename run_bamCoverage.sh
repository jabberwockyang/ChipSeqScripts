#!/bin/bash
cd /root/chipseq

# Load conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate PeakCalling_analysis

# Define directories and parameters
BAM_DIR="bowtie2_e2e"
BIGWIG_DIR="bigwig_e2e"
THREADS=16

# Create output directory if it doesn't exist
mkdir -p $BIGWIG_DIR

# Loop over sorted BAM files in the bam directory
for BAM_FILE in $BAM_DIR/*_e2e.sorted.bam; do
    # Extract sample name from the filename
    SAMPLE_NAME=$(basename $BAM_FILE _e2e.sorted.bam)
    
    # Define output file paths
    BIGWIG_FILE="$BIGWIG_DIR/${SAMPLE_NAME}_e2e.sorted.bw"
    LOG_FILE="$BIGWIG_DIR/${SAMPLE_NAME}_e2e.sorted.log"
    
    # Run bamCoverage
    bamCoverage -b $BAM_FILE -o $BIGWIG_FILE --extendReads --centerReads -p $THREADS 2> $LOG_FILE
done