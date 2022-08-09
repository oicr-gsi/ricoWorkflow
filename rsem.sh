#! /usr/bin/env bash

export FASTQ_1=$1
export FASTQ_2=$2
export LIBRARY_ID=$3
for FILE in $FASTQ_1 $FASTQ_2; do
    export DIRNAME=`dirname $FILE`
    echo ${DIRNAME} >> all_dirs.txt
done
export UNIQUE_DIRS=`cat all_dirs.txt | sort | uniq | paste -sd ","`
echo $UNIQUE_DIRS
stat $FASTQ_1
stat $FASTQ_2
singularity --verbose exec \
	    --bind $UNIQUE_DIRS \
	    /.mounts/labs/CGI/scratch/ibancarz/singularity/rico_adult.sif \
	    stat $FASTQ_1 $FASTQ_2 > stat_inputs.txt

"
singularity --verbose exec \
	    --bind $UNIQUE_DIRS \
	    /.mounts/labs/CGI/scratch/ibancarz/singularity/rico_adult.sif \
	    /rico/RSEM-1.3.0/rsem-calculate-expression \
	    --no-bam-output \
	    --star \
	    --star-path /rico/STAR-2.5.2b/bin/Linux_x86_64/ \
	    --star-gzipped-read-file \
	    --star-output-genome-bam \
	    --estimate-rspd \
	    --paired-end \
	    --seed \
	    12345 \
	    -p \
	    48 \
	    --forward-prob \
	    0 \
	    $FASTQ_1 \
	    $FASTQ_2 \
	    /rico/ref/hg38_no_alt \
	    $LIBRARY_ID
"
