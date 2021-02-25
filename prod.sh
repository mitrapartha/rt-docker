#!/bin/bash

set -euf -o pipefail

# check for needed config files
# these are mounted using docker-compose and are
# required by the setup
[ ! -f RT_SiteConfig.pm ] && echo "RT_SiteConfig.pm does not exist."
[ ! -f ./msmtp/msmtp.conf ] && echo "./msmtp/msmtp.conf does not exist."
[ ! -f ./nginx/certs/pub.pem ] && echo "./nginx/certs/pub.pem does not exist."
[ ! -f ./nginx/certs/priv.pem ] && echo "./nginx/certs/priv.pem does not exist."

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker-compose -f docker-compose.yml pull
docker-compose -f docker-compose.yml stop
docker-compose -f docker-compose.yml rm -f -v -s
docker-compose -f docker-compose.yml up -d
docker image prune -f
