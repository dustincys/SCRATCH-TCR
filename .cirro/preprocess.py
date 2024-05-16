#!/usr/bin/env python3

from cirro.helpers.preprocess_dataset import PreprocessDataset
import pandas as pd
import os

def setup_input_parameters(ds: PreprocessDataset):

    alignment_dataset = [d for d in dataset_inputs if d['process'] == "scratch-alignment-1-0"]
    if len(alignment_dataset) == 0 or len(alignment_dataset) == 1:
        raise RuntimeError(f"Must provide one scratch-alignment-1-0 dataset")

    input_vdj_contigs = f"{alignment_dataset[0]["s3"]}/data/SCRATCH_ALIGN:CELLRANGER_VDJ/**/outs/*"
    ds.add_param('input_vdj_contigs', input_vdj_contigs)

    input_exp_table = f"{alignment_dataset[0]["s3"]}/data/pipeline_info/samplesheet.valid.csv"
    ds.add_param('input_exp_table', input_exp_table)

    ds.remove_param('dataset_inputs')

if __name__ == "__main__":

    ds = PreprocessDataset.from_running()
    setup_input_parameters(ds)

    ds.logger.info("Exported paths:")
    ds.logger.info(os.environ['PATH'])

    ds.logger.info("Files annotated in the dataset:")
    ds.logger.info(ds.files)

    ds.logger.info("Checking metadata:")
    ds.logger.info(ds.samplesheet.columns)

    ds.logger.info("Getwd/LaunchDir directory:")
    ds.logger.info(os.getcwd())

    ds.logger.info("List workdir directory:")
    ds.logger.info(os.listdir("."))

    ds.logger.info("Printing out parameters:")
    ds.logger.info(ds.params)
