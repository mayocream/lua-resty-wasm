#!/bin/bash

version=3.20
build=0

mkdir -p tmp/cmake-temp
cd tmp/cmake-temp

wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
tar -xzvf cmake-$version.$build.tar.gz

cd cmake-$version.$build/

./bootstrap
make -j$(nproc)
sudo make install

cd ..
cd ..
rm -rf ./cmake-temp