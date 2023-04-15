#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 09-temp.txt
date >> 09-temp.txt 

mkdir -p binutils-host-build
cd binutils-host-build

../$BINUTILS_SRC/configure \
    --disable-werror \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	--with-libelf=$addon_tools_dir \
	--with-gmp=$addon_tools_dir \
	--with-mpfr=$addon_tools_dir \
	--with-mpc=$addon_tools_dir \
	2>&1 | tee ../$BINUTILS_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring binutils\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$BINUTILS_SRC-make.txt || { echo -e "\033[1;31mError building binutils\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$BINUTILS_SRC-inst.txt || { echo -e "\033[1;31mError installing binutils\033[0;39m"; exit 1; }

cd ..
rm -rf binutils-host-build

echo "End of build:" >> 09-temp.txt
date >> 09-temp.txt 
mv 09-temp.txt 09-ready.txt


