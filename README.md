# cell_type_specific_AAV_enhancer_discovery

# Cell-Type Specific AAV Enhancer Discovery

This repository contains a workflow for discovering cell-type specific AAV enhancers using integrated scRNA and scATAC data with machine learning algorithms. The workflow is designed to be deployed on cloud platforms including GCP, AWS, and Azure.

## Directory Structure

cell_type_specific_AAV_enhancer_discovery
├── Dockerfile
├── README.md
├── scripts
│ ├── preprocess_data.R
│ ├── integrate_data.R
│ ├── train_model.py
│ ├── predict_enhancers.py
├── nextflow
│ ├── main.nf
│ └── nextflow.config
├── terraform
│ ├── gcp
│ │ └── main.tf
│ ├── aws
│ │ └── main.tf
│ └── azure
│ └── main.tf
├── deployment
│ └── deployment.yaml
└── .gitignore


## Deployment

### GCP

1. Navigate to the `terraform/gcp` directory.
2. Initialize Terraform:
    ```sh
    terraform init
    ```
3. Create a Terraform plan:
    ```sh
    terraform plan -out=tfplan
    ```
4. Apply the Terraform plan:
    ```sh
    terraform apply tfplan
    ```

### AWS

1. Navigate to the `terraform/aws` directory.
2. Initialize Terraform:
    ```sh
    terraform init
    ```
3. Create a Terraform plan:
    ```sh
    terraform plan -out=tfplan
    ```
4. Apply the Terraform plan:
    ```sh
    terraform apply tfplan
    ```

### Azure

1. Navigate to the `terraform/azure` directory.
2. Initialize Terraform:
    ```sh
    terraform init
    ```
3. Create a Terraform plan:
    ```sh
    terraform plan -out=tfplan
    ```
4. Apply the Terraform plan:
    ```sh
    terraform apply tfplan
    ```

## Kubernetes Deployment

1. Build the Docker image:
    ```sh
    docker build -t your-docker-image:latest .
    ```
2. Push the Docker image to a container registry (Docker Hub, GCR, ECR, ACR).
3. Apply the Kubernetes deployment:
    ```sh
    kubectl apply -f deployment/deployment.yaml
    ```

Make sure to configure `kubectl` to point to your Kubernetes cluster.
