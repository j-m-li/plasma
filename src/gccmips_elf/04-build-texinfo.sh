#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 04-temp.txt
date >> 04-temp.txt 

mkdir -p texinfo-build
cd texinfo-build

#export CFLAGS=-D__USE_MINGW_ACCESS

../$TEXINFO_SRC/configure \
	--prefix=$addon_tools_dir \
	2>&1 | tee ../$TEXINFO_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring texinfo\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$TEXINFO_SRC-make.txt || { echo -e "\033[1;31mError building texinfo\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$TEXINFO_SRC-inst.txt || { echo -e "\033[1;31mError installing texinfo\033[0;39m"; exit 1; }

cd ..
rm -rf texinfo-build

echo "End of build:" >> 04-temp.txt
date >> 04-temp.txt 
mv 04-temp.txt 04-ready.txt


