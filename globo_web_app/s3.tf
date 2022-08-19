locals {
  file_logo  = "Globo_logo_Vert.png"
  file_index = "index.html"
}

module "s3_bucket" {
  source                  = "./modules/globo-web-app-s3"
  bucket_name             = lower("${local.name_prefix}-${random_integer.rand.result}")
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags

}

## aws_s3_bucket_object
resource "aws_s3_bucket_object" "website_content" {
  for_each = {
    website = "website/index.html"
    logo    = "website/Globo_logo_Vert.png"
  }
  bucket = module.s3_bucket.web_bucket.bucket
  key    = each.value
  source = "./${each.value}"
  tags   = local.common_tags
}
