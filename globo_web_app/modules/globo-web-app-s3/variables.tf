# Bucket Name
variable "bucket_name" {
  type = string
}

# ELB Service Account
variable "elb_service_account_arn" {
  type = string
}

# Common Tags
variable "common_tags" {
  type = map(string)
}
