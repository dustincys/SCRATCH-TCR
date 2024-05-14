#!/usr/bin/env nextflow

include {  SCIRPY_QUALITY          } from '../../modules/local/scirpy/quality_control/main.nf'
include {  SCIRPY_INTEGRATION      } from '../../modules/local/scirpy/integration/main.nf'

workflow SCRATCH_TCR {

    take:
        ch_vdj_contigs        // channel: []
        ch_exp_table          // channel: []
        ch_annotated_object   // channel: []

    main:

        // Version channel
        ch_versions = Channel.empty()

        // Importing notebook
        ch_notebook_tcr_quality     = Channel.fromPath(params.notebook_tcr_quality, checkIfExists: true)
        ch_notebook_tcr_integration = Channel.fromPath(params.notebook_tcr_integration, checkIfExists: true)

        // Quarto settings
        ch_template    = Channel.fromPath(params.template, checkIfExists: true)
            .collect()

        ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
            .collect()

        ch_page_config = ch_template
            .map{ file -> file.find { it.toString().endsWith('.png') } }
            .combine(ch_page_config)
            .collect()

        // Quality control
        ch_vdj_contigs = ch_vdj_contigs
            .collect()

        SCIRPY_QUALITY(
            ch_notebook_tcr_quality,
            ch_vdj_contigs,
            ch_exp_table,
            ch_page_config
        )

        // ch_anndata_vdj = SCIRPY_QUALITY.anndata

        // Integration
        // SCIRPY_INTEGRATION(
        //     ch_anndata_vdj,
        //     ch_annotated_object
        // )

    emit:
        ch_versions = ch_versions

}
