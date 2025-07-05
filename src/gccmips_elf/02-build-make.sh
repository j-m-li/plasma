#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 02-temp.txt
date >> 02-temp.txt 

mkdir -p make-build
cd make-build

../$MAKE_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	2>&1 | tee ../$MAKE_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring make\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$MAKE_SRC-make.txt || { echo -e "\033[1;31mError building make\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$MAKE_SRC-inst.txt || { echo -e "\033[1;31mError installing make\033[0;39m"; exit 1; }

cd ..
rm -rf make-build

echo "End of build:" >> 02-temp.txt
date >> 02-temp.txt 
mv 02-temp.txt 02-ready.txt
