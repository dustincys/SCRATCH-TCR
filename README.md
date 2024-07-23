# SCRATCH TCR Subworkflows

## Introduction

This repository contains a Nextflow pipeline for analyzing TCR sequencing data. The pipeline integrates various workflows to process and analyze the provided input files, ensuring reproducibility and scalability.

## Prerequisites

Before running the pipeline, ensure you have the following installed:

- [Nextflow](https://www.nextflow.io/) (version 21.04.0 or higher)
- [Java](https://www.oracle.com/java/technologies/javase-downloads.html) (version 8 or higher)
- [Docker](https://www.docker.com/) or [Singularity](https://sylabs.io/singularity/) for containerized execution
- [Git](https://git-scm.com/)

## Installation

Clone the repository to your local machine:

```bash

git clone git@github.com:WangLab-ComputationalBiology/SCRATCH-TCR.git
cd SCRATCH-TCR

```

## Usage

To run the pipeline, use the following command:

```bash

nextflow run main.nf -profile [docker/singularity] --input_vdj_contigs <path/to/vdj_contigs> --input_exp_table <path/to/exp_table> --input_annotated_object <path/to/annotated_object> --project_name <project_name>

```

### Parameters

- `--input_vdj_contigs`: Path to the VDJ contigs input file (required).
- `--input_exp_table`: Path to the expression table input file (required).
- `--input_annotated_object`: Path to the annotated object input file (required).
- `--project_name`: Name of the project for organizing results (required).
- `-profile`: Execution profile. Use `docker` or `singularity` depending on your containerization preference.

### Example

```bash

nextflow run main.nf -profile docker --input_vdj_contigs data/vdj_contigs.csv --input_exp_table data/exp_table.csv --input_annotated_object data/annotated_object.RDS --project_name Melanoma

```

## Configuration

The pipeline can be configured using the `nextflow.config` file. Modify this file to set default parameters, profiles, and other settings.

## Output

Upon successful completion, the results will be available in a directory named after your project (`<project_name>`). You can open the report in your browser:

```plaintext

Done! Open the following report in your browser -> <path/to/launchDir>/<project_name>/report/index.html

```

## Documentation

For more detailed documentation and advanced usage, refer to the [Nextflow documentation](https://www.nextflow.io/docs/latest/index.html) and the comments within the pipeline script (`main.nf`).

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For questions or issues, please contact [your email].