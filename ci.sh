#!/bin/bash
set -e

echo [0/3] preinstall
if [[ "$OSTYPE" =~ ^linux ]]; then
	curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
	sudo apt install -y nodejs
	sudo apt install -y lcov
	sudo apt install -y cppcheck
	sudo apt install -y openssl libssl-dev
	# cmake 3.5
	wget https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz
	tar -zxvf cmake-3.7.2.tar.gz
	cd cmake-3.7.2
	CC=gcc CXX=g++ ./configure
	make -j16
	sudo make install
else
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew doctor
	export PATH="/usr/local/bin:$PATH"
	brew install node
	brew install cmake
	brew install lcov
	brew install cppcheck
fi
pip install --user pyyaml
pip install --user poster
pip install --user codecov

export NOCACHE_LOCAL="${NOCACHE_LOCAL:-TRUE}"
export NOCACHE_REMOTE="${NOCACHE_REMOTE:-FALSE}"
env | sort

if [[ -d "node_modules" ]]; then
	rm -Rf node_modules
fi

if [ -f "package.json" ]; then

	echo [1/3] prepare
	# npm install -g npm-check-updates
	# ncu -u
	npm install https://github.com/makiolo/cmaki
	npm install https://github.com/makiolo/cmaki_scripts
	npm install https://github.com/makiolo/cmaki_generator
	npm install https://github.com/makiolo/cmaki_identifier

	echo [2/3] compile
	npm install --unsafe-perm

	echo [3/3] run tests
	npm test

else

	echo [1/3] prepare
	curl -s https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/bootstrap.sh | bash

	echo [2/3] compile
	./node_modules/cmaki_scripts/install.sh

	echo [3/3] run tests
	./node_modules/cmaki_scripts/tests.sh
fi

if [ -f "cmaki.yml" ]; then
	echo [4/3] upload artifact
	if [ -f "package.json" ]; then
		# IDEA: interesting autogenerate cmaki.yml from package.json
		# echo TODO: generate artifact and upload with cmaki_generator
		npm run upload
	else
		./node_modules/cmaki_scripts/upload.sh
	fi
fi

