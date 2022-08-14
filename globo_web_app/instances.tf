# INSTANCES #
resource "aws_instance" "nginx1" {
  ami                         = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnet1.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.nginx_profile.name
  depends_on                  = [aws_iam_role_policy.allow_s3_all]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
for f in index.html Globo_logo_Vert.png; do
  sudo aws s3 cp s3://${aws_s3_bucket.b.bucket}/website/$f /usr/share/nginx/html/$f
done
EOF

  tags = local.common_tags
}

resource "aws_instance" "nginx2" {
  ami                         = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnet2.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.nginx_profile.id
  depends_on                  = [aws_iam_role_policy.allow_s3_all]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
for f in index.html Globo_logo_Vert.png; do
  sudo aws s3 cp s3://${aws_s3_bucket.b.bucket}/website/$f /usr/share/nginx/html/$f
done
EOF

  tags = local.common_tags
}
