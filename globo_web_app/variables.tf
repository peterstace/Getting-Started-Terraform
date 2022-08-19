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
  type        = map(string)
  description = "The EC2 instance type to use"
}

variable "instance_count" {
  type        = map(number)
  description = "The number of EC2 instances to create"
}

variable "company" {
  type = string
}

variable "project" {
  type = string
}

variable "billing_code" {
  type = string
}

variable "vpc_subnet_count" {
  type        = map(number)
  description = "Number of VPC Subnets to create"
}

variable "vpc_cidr_block" {
  type        = map(string)
  description = "Base CIDR Block for VPC"
}
