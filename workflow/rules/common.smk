import yaml
from pathlib import Path
import pandas as pd


#read the units.tsv file that contains the paths to the fastq.gz files
units = (
    pd.read_csv(config["units"], dtype = str, sep= "\t")
    .set_index(["sample"], drop=False)
)


#a function to get the raw pair-end fastq files from units table that will be an input for the cutadapt rule
def get_rawfastq(wildcards):
  return units.loc[wildcards.sample, ["fq1", "fq2"]]








