export AWS_ACCESS_KEY="$(agepass show personal/aws/access_keys | head -n1 | cut -d' ' -f4)"
export AWS_SECRET_KEY="$(agepass show personal/aws/access_keys | tail -n1 | cut -d' ' -f4)"
