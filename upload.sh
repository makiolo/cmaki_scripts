#!/bin/bash -e
export CMAKI_PWD=$(pwd)
export PACKAGE=$(basename $CMAKI_PWD)
export YMLFILE=$CMAKI_PWD/cmaki.yml
export MODE="${MODE:-Debug}"

cd $CMAKI_PWD/node_modules/cmaki_generator
./build ${PACKAGE} --yaml=${YMLFILE} --server=http://artifacts.myftp.biz:8080

