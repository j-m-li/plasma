#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install newlib
#---------------------------------------------------------------------------------

echo "Start of build:" > 13-temp.txt
date >> 13-temp.txt 

mkdir -p newlib-build
cd newlib-build
mkdir -p etc

../$NEWLIB_SRC/configure \
	--target=$target --prefix=$prefix \
	--disable-newlib-supplied-syscalls \
	--enable-target-optspace \
	2>&1 | tee ../$NEWLIB_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring newlib\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$NEWLIB_SRC-make.txt || { echo -e "\033[1;31mError building newlib\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$NEWLIB_SRC-inst.txt || { echo -e "\033[1;31mError installing newlib\033[0;39m"; exit 1; }

cd ..
rm -rf newlib-build

echo "End of build:" >> 13-temp.txt
date >> 13-temp.txt 
mv 13-temp.txt 13-ready.txt
