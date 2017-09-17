#!/bin/bash
set -e
export CMAKI_PWD="${CMAKI_PWD:-$PWD}"
$CMAKI_PWD/node_modules/cmaki_scripts/setup.sh
$CMAKI_PWD/node_modules/cmaki_scripts/compile.sh

