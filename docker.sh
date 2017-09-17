#!/bin/bash
export IMAGE="${IMAGE:-linux-x64}"
export MODE="${MODE:-Debug}"

git clone -q https://github.com/dockcross/dockcross.git
docker run --rm dockcross/$IMAGE > ./dockcross-$IMAGE
chmod +x ./dockcross-$IMAGE
export CMAKI_EMULATOR=$(./dockcross-$IMAGE bash -c 'echo "message(\${CMAKE_CROSSCOMPILING_EMULATOR})" >> ${CMAKE_TOOLCHAIN_FILE} && cmake -P ${CMAKE_TOOLCHAIN_FILE}')
echo emulator for $IMAGE: $CMAKI_EMULATOR
./dockcross-$IMAGE -a "-e CMAKI_EMULATOR=$CMAKI_EMULATOR -e MODE=$MODE -e NOCACHE_LOCAL=TRUE -e NOCACHE_REMOTE=FALSE" bash -c 'curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/ci.sh | bash'

