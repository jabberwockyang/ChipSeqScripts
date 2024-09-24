#!/bin/bash
cd /root/chipseq

# Load conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate PeakCalling_analysis

# 基础目录
BASE_DIR="fastq"
OUTPUT_DIR="fastp"

# 创建输出目录（如果不存在）
mkdir -p "$OUTPUT_DIR"

# 定义函数来处理每个子目录
run_fastp() {
    local subdir=$1

    # 查找目录中的配对文件
    R1_file=$(find "$subdir" -name "*_R1.fq.gz")
    R2_file=$(find "$subdir" -name "*_R2.fq.gz")

    if [[ -f "$R1_file" && -f "$R2_file" ]]; then
        # 提取子目录名并创建相应的输出目录
        subdir_name=$(basename "$subdir")
        mkdir -p "$OUTPUT_DIR/$subdir_name"

        # 定义输出文件名和报告文件名
        output_R1="$OUTPUT_DIR/$subdir_name/$(basename "${R1_file%.*}_filtered.fq.gz")"
        output_R2="$OUTPUT_DIR/$subdir_name/$(basename "${R2_file%.*}_filtered.fq.gz")"
        html_report="$OUTPUT_DIR/$subdir_name/${subdir_name}_report.html"
        json_report="$OUTPUT_DIR/$subdir_name/${subdir_name}_report.json"

        # 运行 fastp 命令
        echo "Running fastp on $R1_file and $R2_file..."
        fastp -i "$R1_file" -I "$R2_file" -o "$output_R1" -O "$output_R2" -h "$html_report" -j "$json_report"

        echo "Completed processing for $subdir_name."
    else
        echo "No paired R1 and R2 files found in $subdir."
    fi
}

# 导出函数以便在 find 中使用
export -f run_fastp
export OUTPUT_DIR

# 查找所有子目录并运行 fastp
find "$BASE_DIR" -mindepth 1 -maxdepth 1 -type d -exec bash -c 'run_fastp "$0"' {} \;

echo "All processing complete."
