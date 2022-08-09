version 1.0

workflow rico {
  call rsem
}

task rsem {
  input {
    File fastq_1
    File fastq_2
    String library_id
    String modules = "singularity/3.8.2"
    Int timeout = 24
    Int jobMemory = 16
  }

  command <<<
    module load singularity/3.8.2
    # get a comma-separated list of input directories, to bind to the container
    # singularity does not resolve symlinks unless the target directory is bound
    export FASTQ_1=`readlink ~{fastq_1}`
    export FASTQ_2=`readlink ~{fastq_2}`
    for FILE in $FASTQ_1 $FASTQ_2; do
        export DIRNAME=`dirname $FILE`
        echo ${DIRNAME} >> all_dirs.txt
    done
    export UNIQUE_DIRS=`cat all_dirs.txt | sort | uniq | paste -sd ","`
    echo $UNIQUE_DIRS
    # run singularity, allowing time for file cleanup
    singularity --verbose exec \
    --bind $UNIQUE_DIRS \
    /.mounts/labs/CGI/scratch/ibancarz/singularity/rico_adult.sif \
    --version > test.out 2> test.err
>>>

  output {
    File test_out = "test.out"
    File test_err = "test.err"
    #File head1 = "fastq1_head.txt"
    #File head2 = "fastq2_head.txt"
    #File genes = "~{library_id}.genes.results"
    #File isoforms = "~{library_id}.isoforms.results"
  }

}
