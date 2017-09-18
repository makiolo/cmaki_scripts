#!/bin/bash
echo  ------------------- begin compile.sh @ cmaki_scripts
export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
export NOCACHE_LOCAL="${NOCACHE_LOCAL:-FALSE}"
export CC="${CC:-gcc}"
export CXX="${CXX:-g++}"
export MODE="${MODE:-Debug}"
export CMAKI_TARGET="${CMAKI_TARGET:-install}"
export COMPILER_BASENAME=$(basename ${CC})

echo "running in mode $MODE ... ($COMPILER_BASENAME)"
cd $COMPILER_BASENAME/$MODE

# CORES=$(grep -c ^processor /proc/cpuinfo)
CORES=12
cmake --build . --config $MODE --target $CMAKI_TARGET -- -j$CORES -k VERBOSE=1 || cmake --build . --config $MODE --target install -- -j1 VERBOSE=1
code=$?
exit $code
echo  ------------------- end compile.sh @ cmaki_scripts
