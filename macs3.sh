cd /root/chipseq
conda activate PeakCalling_analysis

macs3 callpeak -t aligneddatabowtie2/TNFa_SREBP1_loc.sorted.bam -c aligneddatabowtie2/Input_TNFa_loc.sorted.bam \
-f BAMPE -g hs -n TNFa_SREBP1_loc --outdir PeakDirectory/TNFa_SREBP1_loc 2>PeakDirectory/TNFa_SREBP1_loc.sorted.macs3.log


macs3 callpeak -t aligneddatabowtie2/TNFa_SREBP1_e2e.sorted.bam -c aligneddatabowtie2/Input_TNFa_e2e.sorted.bam \
-f BAMPE -g hs -n TNFa_SREBP1_e2e --outdir PeakDirectory/TNFa_SREBP1_e2e 2>PeakDirectory/TNFa_SREBP1_e2e.sorted.macs3.log


