cd /root/chipseq
conda activate PeakCalling_analysis

# bowtie2-build hg38/BSgenome.Hsapiens.UCSC.hg38.mainChrs.fa hg38-bowtie2/hg38-bowtie2
# 先测试local参数 主要观察比对结果的差异 和时间差异 以尽可能多比对和减少时间为目标

TNFa_SREBP1 using local mode
date
bowtie2 -p 16 -q --local \
-x hg38-bowtie2/hg38-bowtie2 \
-1 fastp/TNFa_SREBP1_R1_filtered.fq.gz \
-2 fastp/TNFa_SREBP1_R2_filtered.fq.gz \
-S aligneddatabowtie2/TNFa_SREBP1_loc.sam 2> aligneddatabowtie2/TNFa_SREBP1_loc.log
date
samtools view aligneddatabowtie2/TNFa_SREBP1_loc.sam -h -S -b -o aligneddatabowtie2/TNFa_SREBP1_loc.bam -@ 16
samtools sort aligneddatabowtie2/TNFa_SREBP1_loc.bam -o aligneddatabowtie2/TNFa_SREBP1_loc.sorted.bam -@ 16
samtools index aligneddatabowtie2/TNFa_SREBP1_loc.sorted.bam -@ 16
samtools flagstat aligneddatabowtie2/TNFa_SREBP1_loc.sorted.bam > aligneddatabowtie2/TNFa_SREBP1_loc.sorted.flagstat

# TNFa_SREBP1 using end-to-end mode
# date
# bowtie2 -p 16 -q \
# -x hg38-bowtie2/hg38-bowtie2 \
# -1 fastp/TNFa_SREBP1_R1_filtered.fq.gz \
# -2 fastp/TNFa_SREBP1_R2_filtered.fq.gz \
# -S aligneddatabowtie2/TNFa_SREBP1_e2e.sam 2> aligneddatabowtie2/TNFa_SREBP1_e2e.log
# date
# samtools view aligneddatabowtie2/TNFa_SREBP1_e2e.sam -h -S -b -o aligneddatabowtie2/TNFa_SREBP1_e2e.bam -@ 16
# samtools sort aligneddatabowtie2/TNFa_SREBP1_e2e.bam -o aligneddatabowtie2/TNFa_SREBP1_e2e.sorted.bam -@ 16
# samtools index aligneddatabowtie2/TNFa_SREBP1_e2e.sorted.bam -@ 16
# samtools flagstat aligneddatabowtie2/TNFa_SREBP1_e2e.sorted.bam > aligneddatabowtie2/TNFa_SREBP1_e2e.sorted.flagstat

# Input_TNFa using local mode
# date
# bowtie2 -p 16 -q --local \
# -x hg38-bowtie2/hg38-bowtie2 \
# -1 fastp/Input_TNFa_R1_filtered.fq.gz \
# -2 fastp/Input_TNFa_R2_filtered.fq.gz \
# -S aligneddatabowtie2/Input_TNFa_loc.sam 2> aligneddatabowtie2/Input_TNFa_loc.log
# date
# samtools view aligneddatabowtie2/Input_TNFa_loc.sam -h -S -b -o aligneddatabowtie2/Input_TNFa_loc.bam -@ 16
# samtools sort aligneddatabowtie2/Input_TNFa_loc.bam -o aligneddatabowtie2/Input_TNFa_loc.sorted.bam -@ 16
# samtools index aligneddatabowtie2/Input_TNFa_loc.sorted.bam -@ 16
# samtools flagstat aligneddatabowtie2/Input_TNFa_loc.sorted.bam > aligneddatabowtie2/Input_TNFa_loc.sorted.flagstat


# Input_TNFa using end-to-end mode
# date
# bowtie2 -p 16 -q \
# -x hg38-bowtie2/hg38-bowtie2 \
# -1 fastp/Input_TNFa_R1_filtered.fq.gz \
# -2 fastp/Input_TNFa_R2_filtered.fq.gz \
# -S aligneddatabowtie2/Input_TNFa_e2e.sam 2> aligneddatabowtie2/Input_TNFa_e2e.log
# date
# samtools view aligneddatabowtie2/Input_TNFa_e2e.sam -h -S -b -o aligneddatabowtie2/Input_TNFa_e2e.bam -@ 16
# samtools sort aligneddatabowtie2/Input_TNFa_e2e.bam -o aligneddatabowtie2/Input_TNFa_e2e.sorted.bam -@ 16
# samtools index aligneddatabowtie2/Input_TNFa_e2e.sorted.bam -@ 16
# samtools flagstat aligneddatabowtie2/Input_TNFa_e2e.sorted.bam > aligneddatabowtie2/Input_TNFa_e2e.sorted.flagstat

