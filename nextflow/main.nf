// main.nf
nextflow.enable.dsl=2

process PREPROCESS_DATA {
    input:
    path scrna_path
    path scatac_path
    path output_path

    output:
    path "${output_path}/scrna_seurat.rds"
    path "${output_path}/scatac_seurat.rds"

    script:
    """
    Rscript scripts/preprocess_data.R ${scrna_path} ${scatac_path} ${output_path}
    """
}

process INTEGRATE_DATA {
    input:
    path scrna_seurat
    path scatac_seurat
    path output_path

    output:
    path "${output_path}/integrated_seurat.rds"

    script:
    """
    Rscript scripts/integrate_data.R ${scrna_seurat} ${scatac_seurat} ${output_path}
    """
}

process TRAIN_MODEL {
    input:
    path integrated_data
    path model_path

    output:
    path "${model_path}/rf_model.pkl"
    path "${model_path}/dl_model.h5"

    script:
    """
    python3 scripts/train_model.py ${integrated_data} ${model_path}
    """
}

process PREDICT_ENHANCERS {
    input:
    path integrated_data
    path model_path
    path output_path

    output:
    path "${output_path}/predictions.csv"

    script:
    """
    python3 scripts/predict_enhancers.py ${integrated_data} ${model_path} ${output_path}
    """
}

workflow {
    params.scrna_path = "path/to/scrna"
    params.scatac_path = "path/to/scatac"
    params.output_path = "path/to/output"
    params.model_path = "path/to/models"
    params.integrated_data = "${params.output_path}/integrated_seurat.rds"
    params.prediction_output = "${params.output_path}/predictions.csv"

    PREPROCESS_DATA(params.scrna_path, params.scatac_path, params.output_path)
    INTEGRATE_DATA("${params.output_path}/scrna_seurat.rds", "${params.output_path}/scatac_seurat.rds", params.output_path)
    TRAIN_MODEL(params.integrated_data, params.model_path)
    PREDICT_ENHANCERS(params.integrated_data, params.model_path, params.prediction_output)
}
