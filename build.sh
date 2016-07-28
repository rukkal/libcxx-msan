#!/bin/bash

NUM_OF_PROCESSORS=$(cat /proc/cpuinfo | grep -c ^processor)

svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
(cd llvm/projects && svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx)
(cd llvm/projects && svn co http://llvm.org/svn/llvm-project/libcxxabi/trunk libcxxabi)

mkdir build
cd build
export CC=clang-3.8
export CXX=clang++-3.8
cmake ../llvm -DCMAKE_INSTALL_PREFIX=.. -DCMAKE_BUILD_TYPE=Release -DLLVM_USE_SANITIZER=Memory
make install-libcxx install-libcxxabi -j$NUM_OF_PROCESSORS
