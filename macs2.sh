macs2(){

	mkdir peaks.OUT
	
	macs2 callpeak -t CA-1.deDup.sorted.bam \
    -B \
  	-c CA-4.deDup.sorted.bam \
   	-f BAM -g 1400000000 \
  	-n CA-1 \
    --outdir peaks.OUT \
    --nomodel \
    --extsize 200 \
    2> CA-1-macs2.log

  	macs2 callpeak -t CA-2.deDup.sorted.bam \
    -B \
  	-c CA-4.deDup.sorted.bam \
   	-f BAM -g 1400000000 \
  	-n CA-1 \
    --outdir peaks.OUT \
    --nomodel \
    --extsize 200 \
  	2> CA-2-macs2.log


}

macs2
