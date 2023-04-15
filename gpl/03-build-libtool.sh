#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 03-temp.txt
date >> 03-temp.txt 

mkdir -p libtool-build
cd libtool-build

../$LIBTOOL_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	2>&1 | tee ../$LIBTOOL_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring libtool\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$LIBTOOL_SRC-make.txt || { echo -e "\033[1;31mError building libtool\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$LIBTOOL_SRC-inst.txt || { echo -e "\033[1;31mError installing libtool\033[0;39m"; exit 1; }

cd ..
rm -rf libtool-build

echo "End of build:" >> 03-temp.txt
date >> 03-temp.txt 
mv 03-temp.txt 03-ready.txt


