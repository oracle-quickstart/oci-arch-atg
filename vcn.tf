## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create VCN

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "atg-vcn"
  dns_label      = "atgvcn"
}

data "oci_core_services" "test_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

# Create Service gateway to allow database server access to object storage bucket for backups

resource "oci_core_service_gateway" "sg" {
  compartment_id = var.compartment_ocid
  services {
    service_id = data.oci_core_services.test_services.services.0.id
  }
  display_name   = "service-gateway"
  vcn_id         = oci_core_virtual_network.vcn.id
}


# Create route table to associate with Storefront Tier Subnet

resource "oci_core_route_table" "subnetart" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subneta-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id

  }
}

# Create security list to associate with Storefront Tier  Subnet

resource "oci_core_security_list" "subnetasl" {
  compartment_id = var.compartment_ocid
  display_name   = "subneta-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.0.0/16"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create private subnet for Storefront Tier  clusters

resource "oci_core_subnet" "subneta" {
  cidr_block        = "10.0.1.0/24"
  display_name      = "subneta"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetart.id
  security_list_ids = [oci_core_security_list.subnetasl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subneta"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

# Create route table to associate with ATG API Tier Subnet

resource "oci_core_route_table" "subnetbrt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subnetb-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id

  }
}

# Create security list to associate with ATG API Tier  Subnet

resource "oci_core_security_list" "subnetbsl" {
  compartment_id = var.compartment_ocid
  display_name   = "subnetb-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.0.0/16"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create private subnet for ATG API Tier 

resource "oci_core_subnet" "subnetb" {
  cidr_block        = "10.0.2.0/24"
  display_name      = "subnetb"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetbrt.id
  security_list_ids = [oci_core_security_list.subnetbsl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subnetb"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}


# Create route table to associate with Endeca MDEX Tier Subnet

resource "oci_core_route_table" "subnetcrt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subnetc-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id

  }
}

# Create security list to associate with Endeca MDEX Tier Subnet

resource "oci_core_security_list" "subnetcsl" {
  compartment_id = var.compartment_ocid
  display_name   = "subnetc-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.0.0/16"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create private subnet for Endeca MDEX Tier 

resource "oci_core_subnet" "subnetc" {
  cidr_block        = "10.0.3.0/24"
  display_name      = "subnetc"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetcrt.id
  security_list_ids = [oci_core_security_list.subnetcsl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subnetc"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

# Create route table to associate with CSC Cluster Subnet

resource "oci_core_route_table" "subnetdrt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subnetd-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id

  }
}

# Create security list to associate with CSC Cluster Subnet

resource "oci_core_security_list" "subnetdsl" {
  compartment_id = var.compartment_ocid
  display_name   = "subnetd-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.0.0/16"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create private subnet for CSC Clusters

resource "oci_core_subnet" "subnetd" {
  cidr_block        = "10.0.4.0/24"
  display_name      = "subnetd"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetdrt.id
  security_list_ids = [oci_core_security_list.subnetdsl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subnetd"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

# Create route table to associate with Auxiliary Services Subnet

resource "oci_core_route_table" "subnetert" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subnete-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id

  }
}

# Create security list to associate with Auxiliary Services Subnet

resource "oci_core_security_list" "subnetesl" {
  compartment_id = var.compartment_ocid
  display_name   = "subnete-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.0.0/16"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create private subnet for Auxiliary Services 

resource "oci_core_subnet" "subnete" {
  cidr_block        = "10.0.5.0/24"
  display_name      = "subnete"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetert.id
  security_list_ids = [oci_core_security_list.subnetesl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subnete"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}


# Create route table to associate with Auxiliary Services Subnet

resource "oci_core_route_table" "subnetfrt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subnetf-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id

  }
}

# Create security list to associate with Auxiliary Services Subnet

resource "oci_core_security_list" "subnetfsl" {
  compartment_id = var.compartment_ocid
  display_name   = "subnetf-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.0.0/16"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create private subnet for Auxiliary Services 

resource "oci_core_subnet" "subnetf" {
  cidr_block        = "10.0.6.0/24"
  display_name      = "subnetf"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetfrt.id
  security_list_ids = [oci_core_security_list.subnetfsl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subnetf"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}


# Create route table to associate with Autonomous Database Subnet

resource "oci_core_route_table" "subnetgrt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "subnetg-rt-table"
  route_rules {
    destination       = lookup(data.oci_core_services.test_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sg.id
  }
}

# Create network security group to associate with Autonomous Database Subnet

resource "oci_core_network_security_group" "dbnsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "Database Security Group"
}

#Ingress

resource "oci_core_network_security_group_security_rule" "db_in" {
  network_security_group_id = oci_core_network_security_group.dbnsg.id

  description = "Database Listener Port"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "10.0.0.0/24"
  tcp_options {
    destination_port_range {
      min = 1522
      max = 1522
    }
  }
}
#Egress
resource "oci_core_network_security_group_security_rule" "db_out" {
  network_security_group_id = oci_core_network_security_group.dbnsg.id

  description = "Outbound Database Traffic"
  direction   = "EGRESS"
  protocol    = 6
  destination_type = "CIDR_BLOCK"
  destination      = "10.0.0.0/24"

}

# Create security list to associate with Autonomous Database Subnet

resource "oci_core_security_list" "subnetgsl" {
  compartment_id = var.compartment_ocid
  display_name   = "subnetg-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.2.0/24"

    tcp_options {
      max = 1522
      min = 1522
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.3.0/24"

    tcp_options {
      max = 1522
      min = 1522
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.4.0/24"

    tcp_options {
      max = 1522
      min = 1522
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "10.0.5.0/24"

    tcp_options {
      max = 1522
      min = 1522
    }
  }
}



# Create private subnet for Autonomous Database 

resource "oci_core_subnet" "subnetg" {
  cidr_block        = "10.0.7.0/24"
  display_name      = "subnetg"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.subnetgrt.id
  security_list_ids = [oci_core_security_list.subnetgsl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = "subnetg"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

# Create Internet gateway to allow inbound and outbound internet traffic

resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.compartment_ocid
  display_name   = "internet-gateway"
  vcn_id         = oci_core_virtual_network.vcn.id
}

# Create route table to associate with Public Load Balancer Subnet

resource "oci_core_route_table" "pubsubart" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "pubsuba-rt-table"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

# Create security list to associate with Public Load Balancer Subnet

resource "oci_core_security_list" "pubsubasl" {
  compartment_id = var.compartment_ocid
  display_name   = "pubsuba-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 8083
      min = 8080
    }
  }
}

# Create public subnet for Public Load Balancer

resource "oci_core_subnet" "pubsuba" {
  cidr_block        = "10.0.100.0/24"
  display_name      = "pubsuba"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.pubsubart.id
  security_list_ids = [oci_core_security_list.pubsubasl.id]
  prohibit_public_ip_on_vnic = false
  dns_label         = "pubsuba"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}


# Create route table to associate with Bastion Host Subnet

resource "oci_core_route_table" "pubsubbrt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "pubsubb-rt-table"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

# Create security list to associate with Public Load Balancer Subnet

resource "oci_core_security_list" "pubsubbsl" {
  compartment_id = var.compartment_ocid
  display_name   = "pubsubb-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 8083
      min = 8080
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }
}

# Create public subnet for Public Load Balancer

resource "oci_core_subnet" "pubsubb" {
  cidr_block        = "10.0.200.0/24"
  display_name      = "pubsubb"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.pubsubbrt.id
  security_list_ids = [oci_core_security_list.pubsubbsl.id]
  prohibit_public_ip_on_vnic = false
  dns_label         = "pubsubb"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}