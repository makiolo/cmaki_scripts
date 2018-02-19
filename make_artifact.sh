#!/bin/bash

export MODE="${MODE:-Debug}"
export CMAKI_INSTALL="${CMAKI_INSTALL:-$CMAKI_PWD/bin}"
export PACKAGE="${PACKAGE:-undefined}"
export YMLFILE="${YMLFILE:-undefined}"

npm update
npm install

if [ "$YMLFILE" == "undefined" ]; then
  if [ "$PACKAGE" == "undefined" ]; then
    echo Error: must define env var YMLFILE or PACKAGE
  else
    echo building $PACKAGE ...
    ./build $PACKAGE --server=http://artifacts.myftp.biz:8080
  fi
else
  echo building from yaml file: ${YMLFILE} ...
  ./build --yaml=${YMLFILE} --server=http://artifacts.myftp.biz:8080
fi
