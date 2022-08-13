export TF_VAR_aws_access_key="$(agepass show personal/aws/access_keys | head -n1 | cut -d' ' -f4)" 
export TF_VAR_aws_secret_key="$(agepass show personal/aws/access_keys | tail -n1 | cut -d' ' -f4)"
