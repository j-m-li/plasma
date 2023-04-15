#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 15-temp.txt
date >> 15-temp.txt 

mkdir -p expat-build
cd expat-build

../$EXPAT_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	2>&1 | tee ../$EXPAT_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring expat\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$EXPAT_SRC-make.txt || { echo -e "\033[1;31mError building expat\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$EXPAT_SRC-inst.txt || { echo -e "\033[1;31mError installing expat\033[0;39m"; exit 1; }

cd ..
rm -rf expat-build

echo "End of build:" >> 15-temp.txt
date >> 15-temp.txt 
mv 15-temp.txt 15-ready.txt


