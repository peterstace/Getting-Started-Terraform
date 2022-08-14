locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  name_prefix = "${var.naming_prefix}-dev"
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}
