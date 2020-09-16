## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_load_balancer" "publb" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.pubsuba.id,
  ]

  display_name = "Storefront-load-balancer"
}

resource "oci_load_balancer_backend_set" "lb-bes1" {
  name             = "lb-bes1"
  load_balancer_id = oci_load_balancer.publb.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    interval_ms         = "10000"
    return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = oci_load_balancer.publb.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bes1.name
  port                     = 8080
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "lb-be1" {
  load_balancer_id = oci_load_balancer.publb.id
  backendset_name  = oci_load_balancer_backend_set.lb-bes1.name
  ip_address       = oci_core_instance.frontend_instance1.private_ip
  port             = 8080
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be2" {
  load_balancer_id = oci_load_balancer.publb.id
  backendset_name  = oci_load_balancer_backend_set.lb-bes1.name
  ip_address       = oci_core_instance.frontend_instance2.private_ip
  port             = 8080
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be3" {
  load_balancer_id = oci_load_balancer.publb.id
  backendset_name  = oci_load_balancer_backend_set.lb-bes1.name
  ip_address       = oci_core_instance.frontend_instance3.private_ip
  port             = 8080
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}