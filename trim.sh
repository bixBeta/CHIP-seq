#!/bin/sh


trim(){

		mkdir TrimQC_stats fastQC trimmed_fastqs
		for i in fastqs/*.gz
		do
			trim_galore --quality 20 --length 10 --gzip --fastqc --fastqc_args " --outdir ./fastQC" $i
		done
		mv *_trimming_report.txt TrimQC_stats
		mv *trimmed.fq.gz trimmed_fastqs

}





align(){
		for i in *.gz
		do
		        iSUB=`echo $i | cut -d "_" -f1`

		        (bowtie2 \
		        --local --no-unal \
		        -x /Users/epigencare/Documents/genomes/chipGenomes/Danio_rerio/UCSC/danRer10/Sequence/Bowtie2Index/genome \
		        -U $i \
		        -S ${iSUB}.sam ) 2>${iSUB}.log

		done

}






#trim
#align

# for i in *.sam
# do
# 	samtools view -@ 24 -b -h -F 0x0100 -O BAM  $i -o $(basename $i .sam).bam

# done


# for i in *.bam
# 	do
#   		samtools sort $i > $(basename $i .bam).sorted.bam
# 	done



# for i in *.sorted.bam
# 	do
# 		samtools index $i
# 	done


# for i in *.sorted.bam
# do
#   samtools flagstat $i > $(basename  $i .sorted.bam).flagstat
#   samtools idxstats $i > $(basename  $i .sorted.bam).idxstats
# done


# source activate homer (multiqc)


# source activate homer 

markDups(){

	  for i in *.sorted.bam
        do
            picard \
            MarkDuplicates \
            INPUT=$i \
            OUTPUT=`basename $i .sorted.bam`.dupMarked.bam \
            ASSUME_SORTED=true \
            REMOVE_DUPLICATES=false \
            METRICS_FILE=`basename $i .sorted.bam`.MarkDuplicates.metrics.txt \
            VALIDATION_STRINGENCY=LENIENT \
            TMP_DIR=tmp

        done
}

# markDups

# for i in *.dupMarked.bam
# do
# 	samtools view -b -h -F 0X400 $i > `basename $i .dupMarked.bam`.deDup.sorted.bam

# done


# for i in *.deDup.sorted.bam; do samtools index $i ; samtools idxstats $i > `echo $i | cut -d "." -f1`.deDup.sorted.idxstats; done
# for i in *.deDup.sorted.bam; do samtools flagstat $i > `echo $i | cut -d "." -f1`.deDup.sorted.flagstat; done




conda activate macs2 # (macs2, python 2.6)


macs2(){

	mkdir peaks.OUT
	
	macs2 callpeak -t CA-1.deDup.sorted.bam \
  	-c CA-4.deDup.sorted.bam \
   	-f BAM -g 1400000000 \
  	-n CA-1 \
    --outdir peaks.OUT \
    --keep-dup all \
    2> CA-1-macs2.log

  	macs2 callpeak -t CA-2.deDup.sorted.bam \
  	-c CA-4.deDup.sorted.bam \
   	-f BAM -g 1400000000 \
  	-n CA-1 \
    --outdir peaks.OUT \
    --keep-dup all
  	2> CA-2-macs2.log


}

macs2









