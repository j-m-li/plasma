#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 06-temp.txt
date >> 06-temp.txt 

mkdir -p gmp-build
cd gmp-build

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

../$GMP_SRC/configure \
	--prefix=$addon_tools_dir --enable-cxx \
	--disable-shared --enable-static \
	$OS_OPTIONS \
	2>&1 | tee ../$GMP_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring gmp\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$GMP_SRC-make.txt || { echo -e "\033[1;31mError building gmp\033[0;39m"; exit 1; }
$MAKE check 2>&1 | tee ../$GMP_SRC-check.txt || { echo -e "\033[1;31mError checking gmp\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$GMP_SRC-inst.txt || { echo -e "\033[1;31mError installing gmp\033[0;39m"; exit 1; }

cd ..
rm -rf gmp-build

echo "End of build:" >> 06-temp.txt
date >> 06-temp.txt 
mv 06-temp.txt 06-ready.txt


