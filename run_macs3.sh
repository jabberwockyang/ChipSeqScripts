#!/bin/bash
cd /root/chipseq

# Load conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate PeakCalling_analysis

# Define directories and parameters
BAM_DIR="bowtie2_e2e"
PEAK_DIR="Peak_e2e"
THREADS=16
GENOME_SIZE="hs"

# Create output directory if it doesn't exist
mkdir -p $PEAK_DIR

# Loop over sorted BAM files in the bam directory
for BAM_FILE in $BAM_DIR/*_e2e.sorted.bam; do
    # Extract sample name and prefix from the filename
    SAMPLE_NAME=$(basename $BAM_FILE _e2e.sorted.bam)
    PREFIX=$(echo $SAMPLE_NAME | cut -d'_' -f1)
    
    # Determine control file based on prefix
    # control file starts with Input_${PREFIX}
    CONTROL_FILES=$(ls $BAM_DIR/Input_${PREFIX}*_e2e.sorted.bam)
    
    if [ -z "$CONTROL_FILES" ]; then
        echo "No control files found for ${PREFIX} in ${BAM_DIR}"
        continue
    fi
    
    for file in $CONTROL_FILES; do
        CONTROL_FILE=$file
        CONTROLBASENAME=$(basename $CONTROL_FILE _e2e.sorted.bam)
        # Define output directory and log file paths
        OUTPUT_DIR="$PEAK_DIR/${SAMPLE_NAME}_${CONTROLBASENAME}_e2e"
        LOG_FILE="$OUTPUT_DIR.sorted.macs3.log"
        
        # Create output directory if it doesn't exist
        mkdir -p $OUTPUT_DIR
        
        # Run MACS3 callpeak
        macs3 callpeak -t $BAM_FILE -c $CONTROL_FILE -m 1 50 -f BAMPE -g $GENOME_SIZE -n ${SAMPLE_NAME}_e2e --outdir $OUTPUT_DIR 2> $LOG_FILE

    done

done
