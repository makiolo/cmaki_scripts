#!/bin/bash

if [[ "$OSTYPE" =~ ^linux ]]; then
	curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
	sudo apt install -y nodejs
	sudo apt install -y lcov
	sudo apt install -y cppcheck
	sudo apt install -y libxaw7-dev  # for OIS
  
	# cmake 3.5 precompiled
	DEPS_DIR=$(pwd)/deps
	if [[ -d "$DEPS_DIR" ]]; then
		rm -Rf $DEPS_DIR
	fi
	CMAKE_FILE=cmake-3.5.2-Linux-x86_64.tar.gz
	CMAKE_URL=http://www.cmake.org/files/v3.5/${CMAKE_FILE}
	wget ${CMAKE_URL} --quiet --no-check-certificate
	mkdir -p cmake
	tar -xzf ${CMAKE_FILE} -C cmake --strip-components 1
	mv cmake ${DEPS_DIR}
	export PATH=${DEPS_DIR}/cmake/bin:${PATH}
	cmake --version
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
