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


for i in *.bam
	do
  		samtools sort $i > $(basename $i .bam).sorted.bam
	done



for i in *.sorted.bam
	do
		samtools index $i
	done


for i in *.sorted.bam
do
  samtools flagstat $i > $(basename  $i .sorted.bam).flagstat
  samtools idxstats $i > $(basename  $i .sorted.bam).idxstats
done


