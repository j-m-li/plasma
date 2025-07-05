#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 05-temp.txt
date >> 05-temp.txt 

mkdir -p libelf-build
cd libelf-build

export libelf_cv_elf_h_works=no

../$LIBELF_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	2>&1 | tee ../$LIBELF_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring libelf\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$LIBELF_SRC-make.txt || { echo -e "\033[1;31mError building libelf\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$LIBELF_SRC-inst.txt || { echo -e "\033[1;31mError installing libelf\033[0;39m"; exit 1; }

cd ..
rm -rf libelf-build

echo "End of build:" >> 05-temp.txt
date >> 05-temp.txt 
mv 05-temp.txt 05-ready.txt


