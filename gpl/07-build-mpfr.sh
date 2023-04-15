#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 07-temp.txt
date >> 07-temp.txt 

mkdir -p mpfr-build
cd mpfr-build

OS=`uname -s`
if [ $OS = "Darwin" ]; then
  OS_OPTIONS=
elif [ $OS = "CYGWIN_NT-5.1" ]; then
  OS_OPTIONS=
elif [ $OS = "MINGW32_NT-5.1" ]; then
  OS_OPTIONS= --build=mingw32
else
  OS_OPTIONS=
fi

../$MPFR_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	--with-gmp=$addon_tools_dir \
	$OS_OPTIONS \
	2>&1 | tee ../$MPFR_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring mpfr\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$MPFR_SRC-make.txt || { echo -e "\033[1;31mError building mpfr\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$MPFR_SRC-inst.txt || { echo -e "\033[1;31mError installing mpfr\033[0;39m"; exit 1; }

cd ..
rm -rf mpfr-build

echo "End of build:" >> 07-temp.txt
date >> 07-temp.txt 
mv 07-temp.txt 07-ready.txt


