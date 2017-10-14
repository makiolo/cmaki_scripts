#!/bin/bash
set -e
export INSTALL_DEPENDS="${INSTALL_DEPENDS:-FALSE}"

if [ "$INSTALL_DEPENDS" = "TRUE" ]; then
	# hacerlo si no esto dentro de un contenedor docker que incluye cmaki_depends
	# sería bueno tener una variable para indicar que el entorno tiene las "cmaki_depends"
	curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/cmaki_depends.sh | bash
fi

export NOCACHE_LOCAL="${NOCACHE_LOCAL:-TRUE}"
export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
env | sort

# todo: use "npm run clean"

if [[ -d "artifacts" ]]; then
	rm -Rf artifacts
fi

if [[ -d "node_modules" ]]; then
	rm -Rf node_modules
fi

if [ -f "package-lock.json" ]; then
	rm package-lock.json
fi

if [ -f "artifacts.json" ]; then
	rm artifacts.json
fi

if [ -f "package.json" ]; then

	echo [1/3] prepare
	npm cache clean --force
	echo rm -Rf $HOME/.npm
	rm -Rf $HOME/.npm
	echo TODO: sudo rm -Rf /var/lib/jenkins/.npm

	echo [2/3] compile
	npm install

	echo [3/3] run tests
	npm test
else
	echo [1/3] prepare
	curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/bootstrap.sh | bash

	echo [2/3] compile
	./node_modules/cmaki_scripts/setup.sh && ./node_modules/cmaki_scripts/compile.sh

	echo [3/3] run tests
	./node_modules/cmaki_scripts/test.sh
fi

if [ -f "cmaki.yml" ]; then
	echo [4/3] upload artifact
	if [ -f "package.json" ]; then
		npm run upload
	else
		./node_modules/cmaki_scripts/upload.sh
	fi
fi
