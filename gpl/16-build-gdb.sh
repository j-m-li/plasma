#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# build and install insight
#---------------------------------------------------------------------------------

echo "Start of build:" > 16-temp.txt
date >> 16-temp.txt 

mkdir -p gdb-build
cd gdb-build

../$GDB_SRC/configure --target=$target --prefix=$prefix --disable-nls \
       $OS_OPTIONS \
       --disable-werror \
	   --disable-shared --enable-static \
	   --with-libelf=$addon_tools_dir \
	   --with-gmp=$addon_tools_dir \
	   --with-mpfr=$addon_tools_dir \
	   --with-mpc=$addon_tools_dir \
       --with-libexpat-prefix=$addon_tools_dir \
	   2>&1 | tee ../$GDB_SRC-cfg.txt \
	|| { echo -e "\033[1;31mError configuring gdb\033[0;39m"; exit 1; }

$MAKE 2>&1 | tee ../$GDB_SRC-make.txt || { echo -e "\033[1;31mError building gdb\033[0;39m"; exit 1; }
$MAKE install 2>&1 | tee ../$GDB_SRC-inst.txt || { echo -e "\033[1;31mError installing gdb\033[0;39m"; exit 1; }

cd ..
rm -rf gdb-build

echo "End of build:" >> 16-temp.txt
date >> 16-temp.txt 
mv 16-temp.txt 16-ready.txt

