phantomtools ENCODE QC metrics for CHIP-Seq:
https://code.google.com/archive/p/phantompeakqualtools/


Header Info:
COL1: Filename: tagAlign/BAM filename 
COL2: numReads: effective sequencing depth i.e. total number of mapped reads in input file 
COL3: estFragLen: comma separated strand cross-correlation peak(s) in decreasing order of correlation. The top 3 local maxima locations that are within 90% of the maximum cross-correlation value are output. In almost all cases, the top (first) value in the list represents the predominant fragment length. If you want to keep only the top value simply run sed -r 's/,[^\t]+//g' > 
COL4: corr_estFragLen: comma separated strand cross-correlation value(s) in decreasing order (col2 follows the same order) 
COL5: phantomPeak: Read length/phantom peak strand shift 
COL6: corr_phantomPeak: Correlation value at phantom peak 
COL7: argmin_corr: strand shift at which cross-correlation is lowest 
COL8: min_corr: minimum value of cross-correlation 
COL9: Normalized strand cross-correlation coefficient (NSC) = COL4 / COL8 
COL10: Relative strand cross-correlation coefficient (RSC) = (COL4 - COL8) / (COL6 - COL8) 
COL11: QualityTag: Quality tag based on thresholded RSC (codes: -2:veryLow,-1:Low,0:Medium,1:High,2:veryHigh)


NSC values range from a minimum of 1 to larger positive numbers. 1.1 is the critical threshold. Datasets with NSC values much less than 1.1 (< 1.05) tend to have low signal to noise or few peaks (this could be biological eg.a factor that truly binds only a few sites in a particular tissue type OR it could be due to poor quality)

RSC values range from 0 to larger positive values. 1 is the critical threshold. RSC values significantly lower than 1 (< 0.8) tend to have low signal to noise. The low scores can be due to failed and poor quality ChIP, low read sequence quality and hence lots of mismappings, shallow sequencing depth (significantly below saturation) or a combination of these. Like the NSC, datasets with few binding sites (< 200) which is biologically justifiable also show low RSC scores.

Differential Peaks using macs2 bdgdiff module (Log10 Likelihood Ratio Stat):
https://github.com/taoliu/MACS/wiki/Call-differential-binding-events
