#!/bin/bash -e

export CC="${CC:-gcc}"
export CXX="${CXX:-g++}"
export MODE="${MODE:-Debug}"
export CMAKI_INSTALL="${CMAKI_INSTALL:-$CMAKI_PWD/bin}"

export PACKAGE=$(basename $CMAKI_PWD)
export YMLFILE=$CMAKI_PWD/cmaki.yml

cd $CMAKI_PWD/node_modules/cmaki_generator
./build ${PACKAGE} --yaml=${YMLFILE} --server=http://artifacts.myftp.biz:8080

