process SCIRPY_INTEGRATION {

    tag "Integrating scRNA to scTCR"
    publishDir "${params.outdir}/${params.project_name}", mode: 'copy'

    input:
        path(notebook)
        path(seurat_object)
        path(config)

    output:
        path("report"), emit: project_folder

    when:
        task.ext.when == null || task.ext.when

    shell:
        """
        quarto render .
        """

    stub:
        """

        """
}