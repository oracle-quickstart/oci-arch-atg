## Copyright © 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_instance" "bastion_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "bastion"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.bastion_ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = true
    display_name     = "bastion_vnic"
    hostname_label   = "bastion"
    subnet_id        = oci_core_subnet.pubsubb.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "orchestrator_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "orchestrator"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = true
    display_name     = "orchestrator_vnic"
    hostname_label   = "orchestrator"
    subnet_id        = oci_core_subnet.pubsubb.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "frontend_instance1" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "frontend-1"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "frontend1_vnic"
    hostname_label   = "frontend1"
    subnet_id        = oci_core_subnet.subneta.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "frontend_instance2" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "frontend-2"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "frontend2_vnic"
    hostname_label   = "frontend2"
    subnet_id        = oci_core_subnet.subneta.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "frontend_instance3" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "frontend-3"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "frontend3_vnic"
    hostname_label   = "frontend3"
    subnet_id        = oci_core_subnet.subneta.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "api_instance1" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "api-instance1"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "api1_vnic"
    hostname_label   = "api1"
    subnet_id        = oci_core_subnet.subnetb.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "api_instance2" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "api-instance2"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "api2_vnic"
    hostname_label   = "api2"
    subnet_id        = oci_core_subnet.subnetb.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "api_instance3" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "api-instance3"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "api3_vnic"
    hostname_label   = "api3"
    subnet_id        = oci_core_subnet.subnetb.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "mdex_instance1" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "mdex-instance1"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "mdex1_vnic"
    hostname_label   = "mdex1"
    subnet_id        = oci_core_subnet.subnetc.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "mdex_instance2" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "mdex-instance2"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "mdex2_vnic"
    hostname_label   = "mdex2"
    subnet_id        = oci_core_subnet.subnetc.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}


resource "oci_core_instance" "csc_instance1" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "csc-instance1"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "csc1_vnic"
    hostname_label   = "csc1"
    subnet_id        = oci_core_subnet.subnetd.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "csc_instance2" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "csc-instance2"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "csc2_vnic"
    hostname_label   = "csc2"
    subnet_id        = oci_core_subnet.subnetd.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "cpp_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "cpp-instance"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "cpp_vnic"
    hostname_label   = "cpp"
    subnet_id        = oci_core_subnet.subnetd.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "csc_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "csc-index-instance"
  shape               = var.instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "cs_index_vnic"
    hostname_label   = "cscindex"
    subnet_id        = oci_core_subnet.subnetd.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "weblogic_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "wl-admin-instance"
  shape               = var.aux_instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "wladmin_vnic"
    hostname_label   = "wladmin"
    subnet_id        = oci_core_subnet.subnete.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "bcc_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "bcc-instance"
  shape               = var.aux_instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "bcc_vnic"
    hostname_label   = "bcc"
    subnet_id        = oci_core_subnet.subnete.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_instance" "aux_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "aux-instance"
  shape               = var.aux_instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "aux_vnic"
    hostname_label   = "aux-svc"
    subnet_id        = oci_core_subnet.subnete.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}


resource "oci_core_instance" "endeca_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "endeca-instance"
  shape               = var.endeca_instance_shape
  metadata            = { ssh_authorized_keys = chomp(file(var.ssh_public_key)) }


  create_vnic_details {
    assign_public_ip = false
    display_name     = "endeca_vnic"
    hostname_label   = "endeca-svc"
    subnet_id        = oci_core_subnet.subnete.id
  }

source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

    timeouts {
    create = "60m"
  }

provisioner "local-exec" {
    command = "sleep 5"
  }
}