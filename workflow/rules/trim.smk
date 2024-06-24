#rule to trim pair-end reads using cutadapt from a conda environemnt

rule cutAdapt_pe:
       input:
         get_rawfastq
       output:
         forwardPaired= "results/cutAdapt/{sample}-trimmed_1.fastq.gz",
         reversePaired= "results/cutAdapt/{sample}-trimmed_2.fastq.gz"
       log:
         "logs/cutAdapt/{sample}.log"
       threads:
         8
       message:
         "Trimming fastq file from {input}"
       conda:
         "../envs/cutAdapt.yaml"
       shell:
         """
         cutadapt -q 20 -m 30 --pair-filter=any --quality-base=33 -j {threads} -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
          -o {output.forwardPaired} -p {output.reversePaired} {input[0]} {input[1]} &> {log}
         """