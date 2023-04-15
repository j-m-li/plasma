#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install the final compiler
#---------------------------------------------------------------------------------

echo "Start of build:" > 14-temp.txt
date >> 14-temp.txt

OS=`uname -s`
if [ $OS = "MINGW32_NT-5.1" ]; then
  MAKE_GCC=mingw32-make
else
  MAKE_GCC=$MAKE
fi

export GCC_EXTRA_CONFIG="LDFLAGS=-static"

cd gcc-build

$MAKE_GCC 2>&1 | tee ../$GCC_SRC-make.txt || { echo -e "\033[1;31mError building gcc2\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$GCC_SRC-inst.txt || { echo -e "\033[1;31mError installing gcc2\033[0;39m"; exit 1; }

cd ..
rm -rf gcc-build

echo "End of build:" >> 14-temp.txt
date >> 14-temp.txt 
mv 14-temp.txt 14-ready.txt
