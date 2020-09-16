## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_file_storage_file_system" "shared_file_system" {
    #Required
    availability_domain = data.oci_identity_availability_domain.ad.name
    compartment_id = var.compartment_ocid

    display_name = var.file_system_display_name
}