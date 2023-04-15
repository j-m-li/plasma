#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install just the c compiler
#---------------------------------------------------------------------------------

echo "Start of build:" > 10-temp.txt
date >> 10-temp.txt 

mkdir -p gcc-host-build
cd gcc-host-build

export GCC_EXTRA_CONFIG="LDFLAGS=-static"

../$GCC_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	--with-gcc --with-gnu-ld --with-gnu-as \
	--enable-languages=c,c++ \
	--with-libelf=$addon_tools_dir \
	--with-gmp=$addon_tools_dir \
	--with-mpfr=$addon_tools_dir \
	--with-mpc=$addon_tools_dir \
	2>&1 | tee ../$GCC_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring gcc\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$GCC_SRC-make.txt || { echo -e "\033[1;31mError building gcc\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$GCC_SRC-inst.txt || { echo -e "\033[1;31mError installing gcc\033[0;39m"; exit 1; }

cd ..
rm -rf gcc-host-build

echo "End of build:" >> 10-temp.txt
date >> 10-temp.txt 
mv 10-temp.txt 10-ready.txt

