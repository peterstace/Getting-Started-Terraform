#!/bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
for f in index.html Globo_logo_Vert.png; do
  sudo aws s3 cp s3://${s3_bucket_name}/website/$f /usr/share/nginx/html/$f
done
