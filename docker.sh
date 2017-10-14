#!/bin/bash
export IMAGE="${IMAGE:-linux-x64}"
export MODE="${MODE:-Debug}"
export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
export NOCACHE_LOCAL="${NOCACHE_LOCAL:-TRUE}"
export DOCKER_OWNER=dockcross

docker run --rm $DOCKER_OWNER/$IMAGE > ./dockcross-$IMAGE
chmod +x ./dockcross-$IMAGE
./dockcross-$IMAGE -a "-e MODE=$MODE -e NOCACHE_LOCAL=$NOCACHE_LOCAL -e NOCACHE_REMOTE=$NOCACHE_REMOTE -e INSTALL_DEPENDS=TRUE" bash -c 'curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/ci.sh | bash'
