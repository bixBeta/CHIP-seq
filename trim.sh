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
align