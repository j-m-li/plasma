#!/bin/bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install various stuff
#---------------------------------------------------------------------------------

echo "Start of build:" > 01-temp.txt
date >> 01-temp.txt 

mkdir -p bash-build
cd bash-build

../$BASH_SRC/configure \
	--prefix=$addon_tools_dir \
	2>&1 | tee ../$BASH_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring bash\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$BASH_SRC-make.txt || { echo -e "\033[1;31mError building bash\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$BASH_SRC-inst.txt || { echo -e "\033[1;31mError installing bash\033[0;39m"; exit 1; }

cd ..
rm -rf bash-build

mkdir -p tar-build
cd tar-build

../$TAR_SRC/configure \
	--prefix=$addon_tools_dir \
	2>&1 | tee ../$TAR_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring tar\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$TAR_SRC-make.txt || { echo -e "\033[1;31mError building tar\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$TAR_SRC-inst.txt || { echo -e "\033[1;31mError installing tar\033[0;39m"; exit 1; }

cd ..
rm -rf tar-build

echo "End of build:" >> 01-temp.txt
date >> 01-temp.txt 
mv 01-temp.txt 01-ready.txt
