#!/bin/bash

ls -ltr

echo  ------------------- begin setup.sh @ cmaki_scripts
export CC="${CC:-gcc}"
export CXX="${CXX:-g++}"
export MODE="${MODE:-Debug}"
export CMAKI_INSTALL="${CMAKI_INSTALL:-$CMAKI_PWD/bin}"

export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
export NOCACHE_LOCAL="${NOCACHE_LOCAL:-FALSE}"
export CMAKI_GENERATOR="${CMAKI_GENERATOR:-Unix Makefiles}"
export COVERAGE="${COVERAGE:-FALSE}"
export TESTS_VALGRIND="${TESTS_VALGRIND:-FALSE}"
export COMPILER_BASENAME=$(basename ${CC})
export CMAKE_TOOLCHAIN_FILE="${CMAKE_TOOLCHAIN_FILE:-"no cross compile"}"

if [ "$CMAKE_TOOLCHAIN_FILE" == "no cross compile" ]; then
	export CMAKE_TOOLCHAIN_FILE_FILEPATH=""
else
	export CMAKE_TOOLCHAIN_FILE_FILEPATH=" -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE"
fi

echo "running in mode $MODE ... ($COMPILER_BASENAME) ($CC / $CXX)"
if [ -f "CMakeCache.txt" ]; then
	rm CMakeCache.txt
fi
if [ -d $COMPILER_BASENAME/$MODE ]; then
	rm -Rf $COMPILER_BASENAME/$MODE
fi
mkdir -p $COMPILER_BASENAME/$MODE

# setup
cd $COMPILER_BASENAME/$MODE
cmake ../.. $CMAKE_TOOLCHAIN_FILE_FILEPATH -DCMAKE_INSTALL_PREFIX=$CMAKI_INSTALL -DCMAKE_BUILD_TYPE=$MODE -DFIRST_ERROR=1 -G"$CMAKI_GENERATOR" -DCMAKE_C_COMPILER="$CC" -DCMAKE_CXX_COMPILER="$CXX" -DNOCACHE_REMOTE=$NOCACHE_REMOTE -DNOCACHE_LOCAL=$NOCACHE_LOCAL -DCOVERAGE=$COVERAGE -DTESTS_VALGRIND=$TESTS_VALGRIND
code=$?
exit $code
echo  ------------------- end setup.sh @ cmaki_scripts

