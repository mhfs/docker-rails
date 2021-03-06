#!/usr/bin/env bash
set -e

aws s3 cp s3://codedeploy-mhfs/cfg/rails_app-mhfs.env /srv/app/app.env --region us-east-1

docker pull mhfs/docker-rails
docker run -d -p 3000:3000 --name rails_app-mhfs --env-file=/srv/app/app.env mhfs/docker-rails
