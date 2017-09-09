#!/bin/bash -e
export CMAKI_PWD=$(pwd)
export PACKAGE=$(basename $CMAKI_PWD)
export YMLFILE=$CMAKI_PWD/cmaki.yml
export MODE="${MODE:-Debug}"

cd $(pwd)/node_modules/cmaki_generator
MODE=Debug ./build ${PACKAGE} --yaml=${YMLFILE} --server=http://artifacts.myftp.biz:8080

