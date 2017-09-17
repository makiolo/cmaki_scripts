#!/bin/bash
export IMAGE="${IMAGE:-linux-x64}"
export MODE="${MODE:-Debug}"
export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
# in docker.sh default is TRUE
export NOCACHE_LOCAL="${NOCACHE_LOCAL:-TRUE}"
export DOCKER_OWNER=dockcross
# export DOCKER_OWNER=makiolo

# if [[ -d dockcross ]]; then
# 	rm -Rf dockcross
# fi
# git clone -q https://github.com/dockcross/dockcross.git

docker run --rm $DOCKER_OWNER/$IMAGE > ./dockcross-$IMAGE
chmod +x ./dockcross-$IMAGE
./dockcross-$IMAGE -a "-e MODE=$MODE -e NOCACHE_LOCAL=$NOCACHE_LOCAL -e NOCACHE_REMOTE=$NOCACHE_REMOTE" bash -c 'curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/ci.sh | bash'
