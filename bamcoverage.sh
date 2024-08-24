cd /root/chipseq
conda activate PeakCalling_analysis


date
bamCoverage -b aligneddatabowtie2/TNFa_SREBP1_loc.sorted.bam  -o bigwig/TNFa_SREBP1_loc.sorted.bw --extendReads --centerReads -p 16 2> bigwig/TNFa_SREBP1_loc.sorted.log
date

date
bamCoverage -b aligneddatabowtie2/TNFa_SREBP1_e2e.sorted.bam  -o bigwig/TNFa_SREBP1_e2e.sorted.bw --extendReads --centerReads -p 16 2> bigwig/TNFa_SREBP1_e2e.sorted.log
date

date
bamCoverage -b aligneddatabowtie2/Input_TNFa_loc.sorted.bam  -o bigwig/Input_TNFa_loc.sorted.bw --extendReads --centerReads -p 16 2> bigwig/Input_TNFa_loc.sorted.log
date

date
bamCoverage -b aligneddatabowtie2/Input_TNFa_e2e.sorted.bam  -o bigwig/Input_TNFa_e2e.sorted.bw --extendReads --centerReads -p 16 2> bigwig/Input_TNFa_e2e.sorted.log
date
