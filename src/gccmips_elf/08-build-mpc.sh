#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install binutils
#---------------------------------------------------------------------------------

echo "Start of build:" > 08-temp.txt
date >> 08-temp.txt 

mkdir -p mpc-build
cd mpc-build

../$MPC_SRC/configure \
	--prefix=$addon_tools_dir \
	--disable-shared --enable-static \
	--with-mpfr=$addon_tools_dir --with-gmp=$addon_tools_dir \
	2>&1 | tee ../$MPC_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring mpc\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$MPC_SRC-make.txt || { echo -e "\033[1;31mError building mpc\033[0;39m"; exit 1; }
$MAKE check 2>&1 | tee ../$MPC_SRC-check.txt || { echo -e "\033[1;31mError checking mpc\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$MPC_SRC-inst.txt || { echo -e "\033[1;31mError installing mpc\033[0;39m"; exit 1; }

cd ..
rm -rf mpc-build

echo "End of build:" >> 08-temp.txt
date >> 08-temp.txt 
mv 08-temp.txt 08-ready.txt


