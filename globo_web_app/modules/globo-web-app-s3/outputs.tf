# Bucket Object
output "web_bucket" {
  value =  aws_s3_bucket.b
}


# Instance Profile Object
output "instance_profile" {
  value = aws_iam_instance_profile.nginx_profile
}
