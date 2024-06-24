#rule to generate the index for salmon quantification

rule salmon_index:
    input:
     config["transcriptome"]
    output:
     directory("results/salmon_index")
    log:
     "logs/salmon_index/salmon_index.log"
    threads:
     8
    message:
     "Generating salmon index from {input}"
    conda:
     "../envs/salmon.yaml"
    shell:
     """
      salmon index \
        -t {input} \
        -i {output} \
        -p {threads} \
        &> {log}
     """

#rule to quantify pair-end reads

rule salmon_quant:
  input: 
   read1 = "results/cutAdapt/{sample}-trimmed_1.fastq.gz",
   read2 = "results/cutAdapt/{sample}-trimmed_2.fastq.gz",
   index = "results/salmon_index"
  output:
   directory("results/salmon_quant/{sample}_quant")
  log:
   "logs/salmon_quant/{sample}.log"
  threads:
   8
  message:
   "Generating quantification files from {input.read1} and {input.read2}"
  conda:
   "../envs/salmon.yaml"
  shell:
   """
    salmon quant \
     -i {input.index} \
     -l A \
     -1 {input.read1} \
     -2 {input.read2} \
     -p {threads} \
     --validateMappings \
     -o {output} \
     &> {log}
   """
