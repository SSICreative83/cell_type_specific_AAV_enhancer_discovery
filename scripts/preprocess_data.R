# preprocess_data.R
library(Seurat)
library(Signac)

preprocess_data <- function(scrna_path, scatac_path, output_path) {
    # Load scRNA data
    scrna_data <- Read10X(data.dir = scrna_path)
    scrna_seurat <- CreateSeuratObject(counts = scrna_data$`Gene Expression`)
    
    # Load scATAC data
    scatac_data <- Read10X_h5(scatac_path)
    scatac_seurat <- CreateSeuratObject(counts = scatac_data)
    
    # Preprocess scRNA data
    scrna_seurat <- NormalizeData(scrna_seurat)
    scrna_seurat <- FindVariableFeatures(scrna_seurat)
    scrna_seurat <- ScaleData(scrna_seurat)
    scrna_seurat <- RunPCA(scrna_seurat)
    
    # Preprocess scATAC data
    scatac_seurat <- NormalizeData(scatac_seurat, assay = "ATAC")
    scatac_seurat <- FindTopFeatures(scatac_seurat, assay = "ATAC", min.cutoff = 10)
    scatac_seurat <- RunTFIDF(scatac_seurat)
    scatac_seurat <- RunSVD(scatac_seurat)
    
    # Save preprocessed data
    saveRDS(scrna_seurat, file = file.path(output_path, "scrna_seurat.rds"))
    saveRDS(scatac_seurat, file = file.path(output_path, "scatac_seurat.rds"))
}

preprocess_data("path/to/scrna", "path/to/scatac", "path/to/output")
