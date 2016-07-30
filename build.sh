#!/bin/bash

if [ ! $# -eq 2 ]; then
   echo "usage: $0 <clang c compiler> <clang c++ compiler>"
   echo "example: $0 clang-3.8 clang++-3.8"
   exit 1
fi

export CC=$1
export CXX=$2
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
