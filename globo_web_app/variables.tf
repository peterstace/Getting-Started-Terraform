variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS Region to use for resources"
  default     = "us-east-1"
}

variable "ec2_instance_type" {
  type        = string
  description = "The EC2 instance type to use"
  default     = "t2.micro"
}

variable "company"      { type = string }
variable "project"      { type = string }
variable "billing_code" { type = string }
