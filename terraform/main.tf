# FAKE "collibra-lite": no cloud account needed.
# terraform_data is a built-in resource that only exists in state, so plan/apply
# run anywhere. In the real project this would be google_compute_instance.

terraform {
  required_version = ">= 1.5"
}

variable "environment" {
  type = string
}

variable "vm_count" {
  type = number
}

variable "machine_type" {
  type = string
}

resource "terraform_data" "vm" {
  count = var.vm_count
  input = {
    name         = "col-edge-${var.environment}-${count.index + 1}"
    machine_type = var.machine_type
  }
}

output "vm_names" {
  value = terraform_data.vm[*].input.name
}
