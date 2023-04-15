#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install just the c compiler
#---------------------------------------------------------------------------------

echo "Start of build:" > 12-temp.txt
date >> 12-temp.txt 

mkdir -p gcc-build
cd gcc-build

export GCC_EXTRA_CONFIG="LDFLAGS=-static"

../$GCC_SRC/configure \
	--target=$target --prefix=$prefix \
	--disable-nls --disable-threads \
	--disable-shared --enable-static \
	--with-gcc --with-gnu-ld --with-gnu-as --with-dwarf2 \
	--enable-languages=c,c++ \
	--with-newlib --with-sysroot=../newlib-$NEWLIB_VER/newlib/libc/include \
	--disable-libssp --disable-libstdcxx-pch --disable-libmudflap \
	--disable-libgomp -v \
	--with-libelf=$addon_tools_dir \
	--with-gmp=$addon_tools_dir \
	--with-mpfr=$addon_tools_dir \
	--with-mpc=$addon_tools_dir \
	2>&1 | tee ../$GCC_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring gcc\033[0;39m"; exit 1; }

mkdir -p libiberty libcpp fixincludes

$MAKE all-gcc 2>&1 | tee ../$GCC_SRC-make.txt || { echo -e "\033[1;31mError building gcc\033[0;39m"; exit 1; }
$MAKE install-gcc 2>&1 | tee ../$GCC_SRC-inst.txt || { echo -e "\033[1;31mError installing gcc\033[0;39m"; exit 1; }

cd ..

echo "End of build:" >> 12-temp.txt
date >> 12-temp.txt 
mv 12-temp.txt 12-ready.txt

