#!/bin/bash
export NOCACHE_LOCAL="${NOCACHE_LOCAL:-FALSE}"
if [ "$NOCACHE_LOCAL" == "TRUE" ]; then
	rm -Rf artifacts 2> /dev/null
fi
rm -Rf coverage 2> /dev/null
rm -Rf gcc 2> /dev/null
rm -Rf clang 2> /dev/null
