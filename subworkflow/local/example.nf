#!/usr/bin/env nextflow

include {  QUARTO_RENDER_PAGEA     } from '../../modules/local/moduleA/main.nf'

workflow NFQUARTO_EXAMPLE {

    take:
        input_annotated_object   // channel: []

    main:

        // Importing notebook
        ch_notebookA   = Channel.fromPath(params.notebookA, checkIfExists: true)

        // Quarto settings
        ch_template    = Channel.fromPath(params.template, checkIfExists: true)
        ch_page_config = Channel.fromPath(params.page_config, checkIfExists: true)
            .collect()

        ch_page_config = ch_template
            .map{ file -> file.find { it.toString().endsWith('.png') } }
            .combine(ch_page_config)
            .collect()

        // Version channel
        ch_versions = Channel.empty()

    emit:
        versions     = ch_versions

}
