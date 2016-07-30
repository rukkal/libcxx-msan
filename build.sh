#!/bin/bash

file_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
num_of_processors=$(cat /proc/cpuinfo | grep -c ^processor)

cd $file_dir
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
(cd llvm/projects && svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx)
(cd llvm/projects && svn co http://llvm.org/svn/llvm-project/libcxxabi/trunk libcxxabi)

[ -d build ] && rm -rf build
mkdir -p build && cd build
cmake ../llvm -DCMAKE_INSTALL_PREFIX=.. -DCMAKE_BUILD_TYPE=Release -DLLVM_USE_SANITIZER=Memory
make install-libcxx install-libcxxabi -j$num_of_processors
