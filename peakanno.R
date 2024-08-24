# https://zhuanlan.zhihu.com/p/609538122


# 要运行 MACS2，我们只需要提供。
# 
# 用于查找富集区域的 BAM 文件。（在 -t 之后指定）
# 峰值呼叫的名称（在 –name 之后指定）。
# 将峰值写入的输出文件夹（在 –outdir 之后指定）。
# 可选，但强烈建议，我们可以确定要比较的控件（在 –c 之后指定）。
library(Herper)
library(reticulate)
library(GenomicRanges)
library(rtracklayer)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)
library(GenomeInfoDb)
library(ChIPseeker)
library(logger)
library(ggplot2)
log_layout(layout_glue_colors)


peakAnno <- function(peakfolder, blkList) {
    setwd(peakfolder)
    peakname <- basename(peakfolder)
    macsPeaks <- paste0(peakname, "_peaks.xls")
    log_info(paste0("Processing ", peakname, " peaks"))
    macsPeaks_DF <- read.delim(macsPeaks, comment.char = "#")
    macsPeaks_DF[1:2, ]

    macsPeaks_GR <- GRanges(seqnames = macsPeaks_DF[, "chr"], IRanges(macsPeaks_DF[, "start"], macsPeaks_DF[, "end"]))
    macsPeaks_GR_filename <- paste0(peakname, "_macsPeaks_GR.txt")
    write.table(as.data.frame(macsPeaks_GR), file = macsPeaks_GR_filename, sep = "\t", quote = FALSE, row.names = FALSE)
    log_info(paste0("Saved GRanges to ", macsPeaks_GR_filename))

    seqnames(macsPeaks_GR)
    ranges(macsPeaks_GR)

    mcols(macsPeaks_GR) <- macsPeaks_DF[, c("abs_summit", "fold_enrichment")]
    macsPeaks_GR
    log_info(paste0("Processed ", peakname, " peaks"))
    nrpeakfilename <- paste0(peakname, "_peaks.narrowPeak")
    # 读取narrowPeak格式的文件
    macsPeaks_GR_np <- read.table(nrpeakfilename, header = TRUE)
    # 检查导入的数据
    head(macsPeaks_GR_np)
    macsPeaks_GR <- macsPeaks_GR[!macsPeaks_GR %over% blkList]

    log_info(paste0("Annotating ", peakname, " peaks"))
    peakAnno <- annotatePeak(macsPeaks_GR,
        tssRegion = c(-3000, 3000),
        TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene,
        annoDb = "org.Hs.eg.db"
    )

    class(peakAnno)
    peakAnno
    peakAnno_GR <- as.GRanges(peakAnno)
    peakAnno_DF <- as.data.frame(peakAnno)
    peakAnno_DF_filename <- paste0(peakname, "_peakAnno_DF.txt")
    write.table(peakAnno_DF, file = peakAnno_DF_filename, sep = "\t", quote = FALSE, row.names = FALSE)

    peakAnno_GR[1:2, ]
    log_info(paste0("Saved GRanges to ", peakAnno_DF_filename))
    
    # save plot
    log_info(paste0("Saving plots for ", peakname))

    p <- plotAnnoBar(peakAnno)
    ggsave(filename = paste0(peakname, "_plotAnnoBar.png"), plot = p, width = 10, height = 7, dpi = 300)

    p <- plotDistToTSS(peakAnno)
    ggsave(filename = paste0(peakname, "_plotDistToTSS.png"), plot = p, width = 10, height = 7, dpi = 300)

    p <- upsetplot(peakAnno, vennpie = F)
    ggsave(filename = paste0(peakname, "_upsetplot.png"), plot = p, width = 10, height = 7, dpi = 300)
}

toBlkList <- "/home/rstudio/ref/hg38.blacklist.bed.gz"
blkList <- import.bed(toBlkList)

setwd("/home/rstudio/Rdata/240619CHIPSEQ")

peakfolder = "peak_240731"
peaksamplefolder = list.dirs(path = peakfolder, full.names = TRUE, recursive = FALSE)

for (i in peaksamplefolder) {
    setwd("/home/rstudio/Rdata/240619CHIPSEQ")
    peakAnno(i, blkList)
}