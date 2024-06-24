#rule to do quality control to the trimmed pair-end reads

rule trimmed_fastqc:
        input:
          "results/cutAdapt/{sample}-trimmed_{read}.fastq.gz"
        output:
          "results/qc/{sample}-trimmed_{read}_fastqc.html",
          "results/qc/{sample}-trimmed_{read}_fastqc.zip"
        log:
          "logs/qc/{sample}-trimmed_{read}.log"
        threads:
          8
        message:
          "Generating trimmed quality files from {input}"
        conda:
          "../envs/fastqc.yaml"
        shell:
          """
          fastqc {input} -t {threads} -o results/qc &> {log}
          """