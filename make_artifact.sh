#!/bin/bash

export MODE="${MODE:-Debug}"
export CMAKI_INSTALL="${CMAKI_INSTALL:-$CMAKI_PWD/bin}"
export PACKAGE="${PACKAGE:-undefined}"
export YMLFILE="${YMLFILE:-undefined}"

if [ "$YMLFILE" == "undefined" ]; then
  if [ "$PACKAGE" == "undefined" ]; then
    echo Error: must define env var YMLFILE or PACKAGE
  else
    ./build $PACKAGE --server=http://artifacts.myftp.biz:8080 -d
  fi
else
  ./build --yaml=${YMLFILE} --server=http://artifacts.myftp.biz:8080
fi
