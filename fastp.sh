cd /home/rstudio/Rdata/240619CHIPSEQ

fastp -i rawdata/TNFa_H3_R1.fq.gz -I rawdata/TNFa_H3_R2.fq.gz -o fastp/TNFa_H3_R1_filtered.fq.gz -O fastp/TNFa_H3_R2_filtered.fq.gz -h fastp/TNFa_H3_report.html -j fastp/TNFa_H3_report.json
fastp -i rawdata/HaCaT_SREBP1_R1.fq.gz -I rawdata/HaCaT_SREBP1_R2.fq.gz -o fastp/HaCaT_SREBP1_R1_filtered.fq.gz -O fastp/HaCaT_SREBP1_R2_filtered.fq.gz -h fastp/HaCaT_SREBP1_report.html -j fastp/HaCaT_SREBP1_report.json
fastp -i rawdata/HaCaT_SREBP2_R1.fq.gz -I rawdata/HaCaT_SREBP2_R2.fq.gz -o fastp/HaCaT_SREBP2_R1_filtered.fq.gz -O fastp/HaCaT_SREBP2_R2_filtered.fq.gz -h fastp/HaCaT_SREBP2_report.html -j fastp/HaCaT_SREBP2_report.json
fastp -i rawdata/TNFa_SREBP2_R1.fq.gz -I rawdata/TNFa_SREBP2_R2.fq.gz -o fastp/TNFa_SREBP2_R1_filtered.fq.gz -O fastp/TNFa_SREBP2_R2_filtered.fq.gz -h fastp/TNFa_SREBP2_report.html -j fastp/TNFa_SREBP2_report.json
fastp -i rawdata/HaCaT_H3_R1.fq.gz -I rawdata/HaCaT_H3_R2.fq.gz -o fastp/HaCaT_H3_R1_filtered.fq.gz -O fastp/HaCaT_H3_R2_filtered.fq.gz -h fastp/HaCaT_H3_report.html -j fastp/HaCaT_H3_report.json
fastp -i rawdata/TNFa_IgG_R1.fq.gz -I rawdata/TNFa_IgG_R2.fq.gz -o fastp/TNFa_IgG_R1_filtered.fq.gz -O fastp/TNFa_IgG_R2_filtered.fq.gz -h fastp/TNFa_IgG_report.html -j fastp/TNFa_IgG_report.json
fastp -i rawdata/HaCaT_IgG_R1.fq.gz -I rawdata/HaCaT_IgG_R2.fq.gz -o fastp/HaCaT_IgG_R1_filtered.fq.gz -O fastp/HaCaT_IgG_R2_filtered.fq.gz -h fastp/HaCaT_IgG_report.html -j fastp/HaCaT_IgG_report.json
fastp -i rawdata/Input_HaCaT_R1.fq.gz -I rawdata/Input_HaCaT_R2.fq.gz -o fastp/Input_HaCaT_R1_filtered.fq.gz -O fastp/Input_HaCaT_R2_filtered.fq.gz -h fastp/Input_HaCaT_report.html -j fastp/Input_HaCaT_report.json
fastp -i rawdata/Input_TNFa_R1.fq.gz -I rawdata/Input_TNFa_R2.fq.gz -o fastp/Input_TNFa_R1_filtered.fq.gz -O fastp/Input_TNFa_R2_filtered.fq.gz -h fastp/Input_TNFa_report.html -j fastp/Input_TNFa_report.json
fastp -i rawdata/TNFa_SREBP1_R1.fq.gz -I rawdata/TNFa_SREBP1_R2.fq.gz -o fastp/TNFa_SREBP1_R1_filtered.fq.gz -O fastp/TNFa_SREBP1_R2_filtered.fq.gz -h fastp/TNFa_SREBP1_report.html -j fastp/TNFa_SREBP1_report.json

fastp -i fastq/HaCaT_H3K4/HaCaT_H3K4_R1.fq.gz -I fastq/HaCaT_H3K4/HaCaT_H3K4_R2.fq.gz -o fastp/HaCaT_H3K4/HaCaT_H3K4_R1_filtered.fq.gz -O fastp/HaCaT_H3K4/HaCaT_H3K4_R2_filtered.fq.gz -h fastp/HaCaT_H3K4/HaCaT_H3K4_report.html -j fastp/HaCaT_H3K4/HaCaT_H3K4_report.json
