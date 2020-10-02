resource "oci_core_instance" "awx" {
  agent_config {
    is_management_disabled = false
    is_monitoring_disabled = false
  }
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  create_vnic_details {
    assign_public_ip = var.public_ip
    hostname_label   = "awx"
    subnet_id        = var.subnet_ocid
  }
  display_name = "awx"
  fault_domain = var.fault_domain
  launch_options {
    boot_volume_type        = "PARAVIRTUALIZED"
    firmware                = "UEFI_64"
    network_type            = "PARAVIRTUALIZED"
    remote_data_volume_type = "PARAVIRTUALIZED"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = data.cloudinit_config.awx.rendered
  }
  shape = var.shape
  source_details {
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
    # source_id = var.image_id
    source_id   = var.image_oraclelinux_7[var.region]
    source_type = "image"
  }
}
