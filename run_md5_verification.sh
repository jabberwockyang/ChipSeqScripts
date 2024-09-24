#!/bin/bash
cd /root/chipseq

# Load conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate PeakCalling_analysis

# Base directory containing the fastq files
BASE_DIR="fastq"

# Function to verify MD5 checksum for each .fq.gz file
verify_md5() {
    local dir=$1
    
    # Loop through each .md5 file in the directory
    for md5_file in "$dir"/*.md5; do
        if [[ -f "$md5_file" ]]; then
            # Extract the expected checksum and the corresponding file name from the .md5 file
            expected_md5=$(cut -d ' ' -f 1 "$md5_file")
            fq_file="$dir/$(basename "$md5_file" .md5)"
            
            # Calculate the actual checksum of the .fq.gz file
            actual_md5=$(md5sum "$fq_file" | cut -d ' ' -f 1)
            
            # Compare the checksums
            if [[ "$expected_md5" == "$actual_md5" ]]; then
                echo "Verification passed: $fq_file"
            else
                echo "Verification failed: $fq_file"
            fi
        fi
    done
}

# Export the base directory recursively
export -f verify_md5

# Find all subdirectories and verify checksums in each
find "$BASE_DIR" -type d -exec bash -c 'verify_md5 "$0"' {} \;

echo "MD5 verification complete."
