locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
    environment  = terraform.workspace
  }

  name_prefix = "${var.naming_prefix}-${terraform.workspace}"
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}
