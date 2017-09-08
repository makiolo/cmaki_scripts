#!/bin/bash
set -e

export CMAKI_PWD="${CMAKI_PWD:-$PWD}"
export MODE="${MODE:-Debug}"
export CMAKI_IDENTIFIER_FOLDER=$CMAKI_PWD/cmaki_identifier
export PACKAGE=$(basename $(pwd))

# setup
$CMAKI_PWD/node_modules/cmaki_scripts/setup.sh

# compile
$CMAKI_PWD/node_modules/cmaki_scripts/compile.sh

