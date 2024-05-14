#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { SCRATCH_TCR } from './subworkflow/local/scratch_tcr.nf'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Check mandatory parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

if (params.input_exp_table) { input_exp_table = file(params.input_exp_table) } else { exit 1, 'Please, provide a --input <PATH/TO/seurat_object.RDS> !' }
if (params.input_annotated_object) { input_annotated_object = file(params.input_annotated_object) } else { exit 1, 'Please, provide a --input <PATH/TO/seurat_object.RDS> !' }

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN ALL WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {

    log.info """\

        Parameters:

        VDJ: ${input_vdj_contigs}
        Metadata: ${input_exp_table}
        Annotated: ${input_annotated_object}

    """

    // Description
    ch_vdj_contigs      = Channel.fromPath(params.input_vdj_contigs, checkIfExists: true)
    ch_exp_table        = Channel.fromPath(params.input_exp_table, checkIfExists: true)
    ch_annotated_object = Channel.fromPath(params.input_annotated_object, checkIfExists: true)

    SCRATCH_TCR(
        ch_vdj_contigs,
        ch_exp_table,
        ch_annotated_object
    )

}

workflow.onComplete {
    log.info(
        workflow.success ? "\nDone! Open the following report in your browser -> ${launchDir}/${params.project_name}/report/index.html\n" :
        "Oops... Something went wrong"
    )
}
