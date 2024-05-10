#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { NFQUARTO_EXAMPLE } from './subworkflow/local/example.nf'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Check mandatory parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

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
        Annotated: ${input_annotated_object}

    """

    // Description
    input_annotated_object       = Channel.fromPath(params.input_annotated_object, checkIfExists: true)

    NFQUARTO_EXAMPLE(
        input_annotated_object
    )

}

workflow.onComplete {
    log.info(
        workflow.success ? "\nDone! Open the following report in your browser -> ${launchDir}/${params.project_name}/report/index.html\n" :
        "Oops... Something went wrong"
    )
}
