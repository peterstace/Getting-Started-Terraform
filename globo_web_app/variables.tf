variable "naming_prefix" {
  type        = string
  description = "Prefix for AWS resource names"
  default     = "globoweb"
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

variable "instance_count" {
  type        = number
  description = "The number of EC2 instances to create"
  default     = 2
}

variable "company" {
  type    = string
}

variable "project" {
  type    = string
}

variable "billing_code" {
  type    = string
}

variable "vpc_subnet_count" {
  type        = number
  description = "Number of VPC Subnets to create"
  default     = 2
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}
