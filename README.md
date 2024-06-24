# Pair-end Long RNA-seq Snakemake Pipeline

[![Snakemake](https://img.shields.io/badge/snakemake-≥8.14.0-brightgreen.svg)](https://snakemake.readthedocs.io/en/stable/)

This is a snakemake-based pipeline that handles the pre-processing of pair-end long RNAseq data.

It trims pair-end sequencing files, and then does the quality control on the trimmed files, followed by indexing the reference transcriptome that will be used for the quantification step in Salmon.

## Files Setup

The paths to the raw files that should be in `.fastq.gz` format should be added to the `units.tsv` file in the `configuration` folder.

The reference `gencode.vM1.pc_transcripts.fa.gz` was used for indexing in this pipeline and it can be found in the `resources` folder. You can use another reference transcriptome that should be in `.gz` format, but remember to change the path to it in `config.yaml` file in the `configuration` folder.


### Format of units.tsv file

Below is the structure of the `units.tsv` file:

| sample | unit | fq1 | fq2 |
|--------|------|-----|------|
| name_of_sample | name_of_technicalReplicate_unit | path/to/read1.fastq.gz | path/to/read2.fastq.gz |

**NOTE:** unit column is not taken into consideration in this pipeline, since the technical replicates are handled as individual samples and are not merged. The units column is only recorded as additional information about the data. Hence, the number of the technical replicate if it exists should be added as part of the sample's name in the sample column.

Example on how the to fill the `units.tsv` file:

| sample | unit | fq1 | fq2 |
|--------|------|-----|------|
| sample1_rep1 | flow_cell1 | path/to/read1_rep1.fastq.gz | path/to/read2_rep1.fastq.gz |
| sample1_rep2 | flow_cell2 | path/to/read1_rep2.fastq.gz | path/to/read2_rep2.fastq.gz |


* In the above example, the sample was sequenced in 2 different Flow Cells leading to 2 technical replicates of the same sample, but as previously mentioned, the replicates of the same sample will be processed as 2 seperate individual samples.


### Running the pipeline

* First, ensure that Conda/Mamba are installed ([Check Snakemake documentation for more detials](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)) and the required channels (i.e. `bioconda`, `conda-forge`) are added.

* Second, create a snakemake environment within Conda/Mamba and activate it.

* Third, create a results folder to save the snakemake.log file into.
**NOTE:** This command should be only done when there is no results folder generated yet.

```bash
mkdir results
```

* Then run the below command to unlock the working directory of snakemake.

```bash
snakemake --unlock
```

* Finally you can run the pipeline with the following command:

```bash
nohup snakemake --use-conda --cores 4 --latency-wait 120 --jobs 10 &>> results/snakemake.log&
```

