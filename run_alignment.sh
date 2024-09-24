#!/bin/bash
cd /root/chipseq

# Load conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate PeakCalling_analysis


# Define whether to use local alignment mode (true/false)
local=false  # Change this to false to use end-to-end mode
# Set mode-specific parameters and file suffix
if [ "$local" = true ]; then
    ALIGN_MODE="--local"
    SUFFIX="_loc"
else
    ALIGN_MODE="--end-to-end"
    SUFFIX="_e2e"
fi

# Define directories and parameters
FASTP_DIR="fastp"
BOWTIE2_INDEX="hg38-bowtie2/hg38-bowtie2"
THREADS=16
OUTPUT_DIR="bowtie2${SUFFIX}"
# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Define a function to process files in a subdirectory
process_subdirectory() {
    local subdir=$1
    echo "Processing directory: $subdir"

    # Find R1 filtered files in the subdirectory
    for R1_FILE in "$subdir"/*_R1.fq_filtered.fq.gz; do

        R2_FILE="${R1_FILE/_R1.fq_filtered.fq.gz/_R2.fq_filtered.fq.gz}"
        # Check if the R1 file exists to avoid errors if there are no matching files
        if [[ -f "$R2_FILE" ]]; then

            # Extract sample name from the filename
            SAMPLE_NAME=$(basename "$R1_FILE" "_R1.fq_filtered.fq.gz")
            
            # Define output file paths with mode-specific suffix
            SAM_FILE="$OUTPUT_DIR/${SAMPLE_NAME}${SUFFIX}.sam"
            BAM_FILE="$OUTPUT_DIR/${SAMPLE_NAME}${SUFFIX}.bam"
            SORTED_BAM_FILE="$OUTPUT_DIR/${SAMPLE_NAME}${SUFFIX}.sorted.bam"
            FLAGSTAT_FILE="$OUTPUT_DIR/${SAMPLE_NAME}${SUFFIX}.sorted.flagstat"
            LOG_FILE="$OUTPUT_DIR/${SAMPLE_NAME}${SUFFIX}.log"
            
            # Log start time
            echo "Alignment start time: $(date)" >> "$LOG_FILE"
            
            # Run Bowtie2 with mode-specific parameters
            echo "Running Bowtie2 for $SAMPLE_NAME in mode $ALIGN_MODE..."
            bowtie2 -p $THREADS -q -x "$BOWTIE2_INDEX" -1 "$R1_FILE" -2 "$R2_FILE" $ALIGN_MODE -S "$SAM_FILE" 2>> "$LOG_FILE"
            
            # Log end time
            echo "Alignment end time: $(date)" >> "$LOG_FILE"
            
            # Convert SAM to BAM
            echo "Converting SAM to BAM for $SAMPLE_NAME..."
            samtools view "$SAM_FILE" -h -S -b -o "$BAM_FILE" -@ $THREADS
            
            # Delete SAM file to save space
            rm "$SAM_FILE"
            
            # Sort BAM file
            echo "Sorting BAM for $SAMPLE_NAME..."
            samtools sort "$BAM_FILE" -o "$SORTED_BAM_FILE" -@ $THREADS

            # Remove intermediate BAM file to save space
            rm "$BAM_FILE"

            # Index sorted BAM file
            echo "Indexing sorted BAM for $SAMPLE_NAME..."
            samtools index "$SORTED_BAM_FILE" -@ $THREADS
            
            # Generate flagstat report
            echo "Generating flagstat report for $SAMPLE_NAME..."
            samtools flagstat "$SORTED_BAM_FILE" > "$FLAGSTAT_FILE"
            
            echo "Processing complete for $SAMPLE_NAME."
            echo "------------------------------------------------------"
        fi
    done
}

# Export the function to use in find command
export -f process_subdirectory
export BOWTIE2_INDEX OUTPUT_DIR THREADS ALIGN_MODE SUFFIX

# Traverse subdirectories in the fastp directory and process each
find "$FASTP_DIR" -mindepth 1 -maxdepth 1 -type d -exec bash -c 'process_subdirectory "$0"' {} \;

echo "All alignments are complete."