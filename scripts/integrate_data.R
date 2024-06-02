# integrate_data.R
library(Seurat)
library(Signac)

integrate_data <- function(scrna_path, scatac_path, output_path) {
    # Load preprocessed data
    scrna_seurat <- readRDS(scrna_path)
    scatac_seurat <- readRDS(scatac_path)
    
    # Integrate scRNA and scATAC data
    integrated <- FindIntegrationAnchors(object.list = list(scrna_seurat, scatac_seurat), dims = 1:30)
    integrated <- IntegrateData(anchorset = integrated)
    
    # Save integrated data
    saveRDS(integrated, file = file.path(output_path, "integrated_seurat.rds"))
}

integrate_data("path/to/scrna_seurat.rds", "path/to/scatac_seurat.rds", "path/to/output")
