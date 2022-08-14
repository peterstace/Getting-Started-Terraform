# INSTANCES #
resource "aws_instance" "nginx" {
  count                       = var.instance_count
  ami                         = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnets[count.index % length(aws_subnet.subnets)].id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.nginx_profile.name
  depends_on                  = [aws_iam_role_policy.allow_s3_all]

  user_data = templatefile(
    "${path.module}/startup_script.tpl",
    {s3_bucket_name = aws_s3_bucket.b.id},
  )
  tags = local.common_tags
}
