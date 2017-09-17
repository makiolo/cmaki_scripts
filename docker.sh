#!/bin/bash
export IMAGE="${IMAGE:-linux-x64}"
export MODE="${MODE:-Debug}"

if [[ -d dockcross ]]; then
	rm -Rf dockcross
fi
git clone -q https://github.com/dockcross/dockcross.git
docker run --rm dockcross/$IMAGE > ./dockcross-$IMAGE
chmod +x ./dockcross-$IMAGE
./dockcross-$IMAGE -a "-e MODE=$MODE -e NOCACHE_LOCAL=TRUE -e NOCACHE_REMOTE=FALSE" bash -c 'curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/ci.sh | bash'

