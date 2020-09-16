## Copyright © 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Variables
variable "tenancy_ocid" {
}

variable "compartment_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
}

variable "ssh_public_key" {
}

variable "bastion_ssh_public_key" {
}

variable "ssh_private_key" {
}

# Specify any Default Value's here

#variable "availability_domain" {
#  default = "3"
#}

variable "ad_number" {
  default     = 0
  description = "Which availability domain to deploy to depending on quota, zero based."
}

variable "ad_name" {
  default = ""
}

#Object Storage Bucket Variables

variable "bucket_name" {
  default = "data_bucket"
}
   
variable "bucket_namespace" {
}


variable "bucket_access_type" {
  default ="NoPublicAccess"
}

variable "bucket_storage_tier" {
  default = "Standard"
}

variable "bucket_versioning" { 
  default = "Disabled"
}


# Variables for File Storage Service

variable "file_system_display_name" {
  default = "Shared File Storage"
}

# Variables for Compute

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "aux_instance_shape" {
  default = "VM.Standard2.2"
}

variable "endeca_instance_shape" {
  default = "VM.Standard2.4"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.8"
}

# Variables for Autonomous Database

variable "autonomous_database_cpu_core_count" {
  default = "1"
}


variable "autonomous_database_admin_password" {
}

variable "autonomous_database_db_name" {
  default = "ATGDB"
}

variable "autonomous_database_display_name" {
  default = "Commerce DB"
}

variable "autonomous_database_is_auto_scaling_enabled" {
  default = "false"
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = "1"
}

variable "autonomous_database_db_workload" {
  default = "OLTP"
}

variable "autonomous_database_license_model" {
  default = "BRING_YOUR_OWN_LICENSE"
}

variable "autonomous_database_data_safe_status" {
  default = "NOT_REGISTERED"
}