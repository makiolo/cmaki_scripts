#!/bin/bash
NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
NOCACHE_LOCAL="${NOCACHE_LOCAL:-FALSE}"
export CC="${CC:-gcc}"
export CXX="${CXX:-g++}"
export MODE="${MODE:-Debug}"
export COMPILER_BASENAME=$(basename ${CC})

echo "running in mode $MODE ... ($COMPILER_BASENAME)"
cd $COMPILER_BASENAME/$MODE

# CORES=$(grep -c ^processor /proc/cpuinfo)
CORES=12
cmake --build . --config $MODE --target install -- -j$CORES -k VERBOSE=1 || cmake --build . --config $MODE --target install -- -j1 VERBOSE=1
code=$?
exit $code
