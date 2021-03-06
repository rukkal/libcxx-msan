# libcxx-msan
> - A bash script to build the LLVM libc++ with memory sanitizer instrumentation
- A bash script to be sourced in order to use the instrumented libc++

## How to use it
1. build the instrumented libc++:
```shell
export CC=clang
export CXX=clang++
./build.sh
```
feel free to change CC and CXX with you favorite clang version
- load the environment to make clang use the instrumented libc++:
```shell
source load-environment
```

Now you are ready to go. You can compile your program using the memory sanitizer. E.g.
```shell
$CXX -stdlib=libc++ -fsanitize=memory test.cpp -o test
```

**Important**: don't forget to pass -stdlib=libc++. Otherwise clang might use the GNU libstdc++ (default on Linux).
