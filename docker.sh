#!/bin/bash
export IMAGE="${IMAGE:-linux-x64}"
export MODE="${MODE:-Debug}"
export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
export NOCACHE_LOCAL="${NOCACHE_LOCAL:-TRUE}"

docker run --rm makiolo/$IMAGE > ./dockcross-$IMAGE
sed -e 's#DEFAULT_DOCKCROSS_IMAGE=dockcross/linux-x64#DEFAULT_DOCKCROSS_IMAGE=makiolo/linux-x64#g' dockcross-$IMAGE > makiolo-$IMAGE
chmod +x ./makiolo-$IMAGE
./makiolo-$IMAGE -a "-e MODE=$MODE -e NOCACHE_LOCAL=$NOCACHE_LOCAL -e NOCACHE_REMOTE=$NOCACHE_REMOTE -e INSTALL_DEPENDS=FALSE" bash -c 'curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/ci.sh | bash'
