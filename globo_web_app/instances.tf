# INSTANCES #
resource "aws_instance" "nginx" {
  count                       = var.instance_count[terraform.workspace]
  ami                         = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type               = var.ec2_instance_type[terraform.workspace]
  subnet_id                   = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  user_data_replace_on_change = true
  iam_instance_profile        = module.s3_bucket.instance_profile.name
  depends_on                  = [module.s3_bucket]

  user_data = templatefile(
    "${path.module}/startup_script.tpl",
    { s3_bucket_name = module.s3_bucket.web_bucket.bucket },
  )

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nginx-${count.index}"
  })
}
