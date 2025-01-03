variable "credentials_file_path" {
  description = "Path to the GCP credentials JSON file"
  type        = string
}

variable "project_name" {
  description = "The name of the GCP project"
  type        = string
}

variable "project_id" {
  description = "The unique ID for the GCP project"
  type        = string
}

variable "billing_acct_id" {
  description = "The billing account ID"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vm_size" {
  description = "The machine type for the VM"
  type        = string
  default     = "n1-standard-1"  # You can adjust this default value
}

variable "region" {
  description = "The region for the resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone for the VM"
  type        = string
  default     = "us-central1-a"
}
