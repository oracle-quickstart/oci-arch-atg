## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create Private Load Balancer and associated resources for ATG API tier
resource "oci_load_balancer" "privlb1" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.subnetb.id,
  ]

  display_name = "ATG-API-load-balancer"
  is_private = true
}

resource "oci_load_balancer_backend_set" "privlb-bes1" {
  name             = "privlb-bes1"
  load_balancer_id = oci_load_balancer.privlb1.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "7001"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "privlb-listener1" {
  load_balancer_id         = oci_load_balancer.privlb1.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.privlb-bes1.name
  port                     = 7001
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "privlb1-be1" {
  load_balancer_id = oci_load_balancer.privlb1.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes1.name
  ip_address       = oci_core_instance.api_instance1.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "privlb1-be2" {
  load_balancer_id = oci_load_balancer.privlb1.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes1.name
  ip_address       = oci_core_instance.api_instance2.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "privlb3-be3" {
  load_balancer_id = oci_load_balancer.privlb1.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes1.name
  ip_address       = oci_core_instance.api_instance3.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

# Create Private Load Balancer and associated resources for Endeca MDEX tier
resource "oci_load_balancer" "privlb2" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.subnetc.id,
  ]

  display_name = "Endeca-MDEX-load-balancer"
  is_private = true
}

resource "oci_load_balancer_backend_set" "privlb-bes2" {
  name             = "privlb-bes2"
  load_balancer_id = oci_load_balancer.privlb2.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "7001"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "privlb-listener2" {
  load_balancer_id         = oci_load_balancer.privlb2.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.privlb-bes2.name
  port                     = 7001
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "privlb2-be1" {
  load_balancer_id = oci_load_balancer.privlb2.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes2.name
  ip_address       = oci_core_instance.mdex_instance1.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "privlb2-be2" {
  load_balancer_id = oci_load_balancer.privlb2.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes2.name
  ip_address       = oci_core_instance.mdex_instance2.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

# Create Private Load Balancer and associated resources for CSC tier
resource "oci_load_balancer" "privlb3" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.subnetd.id,
  ]

  display_name = "CSC-load-balancer"
  is_private = true
}

resource "oci_load_balancer_backend_set" "privlb-bes3" {
  name             = "privlb-bes3"
  load_balancer_id = oci_load_balancer.privlb3.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "7001"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "privlb-listener3" {
  load_balancer_id         = oci_load_balancer.privlb3.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.privlb-bes3.name
  port                     = 7001
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "privlb3-be1" {
  load_balancer_id = oci_load_balancer.privlb3.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes3.name
  ip_address       = oci_core_instance.csc_instance1.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "privlb3-be2" {
  load_balancer_id = oci_load_balancer.privlb3.id
  backendset_name  = oci_load_balancer_backend_set.privlb-bes3.name
  ip_address       = oci_core_instance.csc_instance2.private_ip
  port             = 7001
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

