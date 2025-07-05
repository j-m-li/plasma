#!/bin/bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# Setup the environment
# 
# This is done by a separate script, because if you have close your shell
# you can set the environment again with this script only.
#---------------------------------------------------------------------------------

mkdir -p $prefix
mkdir -p $addon_tools_dir

echo -e "$GNU_TOOLCHAIN_INSTALL\n\n"\
		"$BASH_SRC\n"\
		"$BINUTILS_SRC\n"\
		"$EXPAT_SRC\n"\
		"$GCC_SRC\n"\
		"$GDB_SRC\n"\
		"$GMP_SRC\n"\
		"$LIBELF_SRC\n"\
		"$LIBTOOL_SRC\n"\
		"$MAKE_SRC\n"\
		"$MPC_SRC\n"\
		"$MPFR_SRC\n"\
		"$NEWLIB_SRC\n"\
		"$TAR_SRC\n"\
		"$TEXINFO_SRC\n" > $prefix/README.TXT

#---------------------------------------------------------------------------------
# Extract source packages
#---------------------------------------------------------------------------------

echo -e "\033[1;31mExtracting $BINUTILS_SRC\033[0;39m"
tar -xjvf $download_dir/binutils-$BINUTILS_VER.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$BINUTILS_SRC; exit; }

echo -e "\033[1;31mExtracting $GCC_CORE_SRC\033[0;39m"
tar -xjvf $download_dir/$GCC_CORE_SRC.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$GCC_CORE_SRC; exit; }

echo -e "\033[1;31mExtracting $GCC_GPP_SRC\033[0;39m"
tar -xjvf $download_dir/$GCC_GPP_SRC.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$GCC_GPP_SRC; exit; }

echo -e "\033[1;31mExtracting $NEWLIB_SRC\033[0;39m"
tar -xzvf $download_dir/$NEWLIB_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$NEWLIB_SRC; exit; }

echo -e "\033[1;31mExtracting $GDB_SRC\033[0;39m"
tar -xjvf $download_dir/$GDB_SRC.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$GDB_SRC; exit; }

echo -e "\033[1;31mExtracting $GMP_SRC\033[0;39m"
tar -xjvf $download_dir/$GMP_SRC.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$GMP_SRC; exit; }

echo -e "\033[1;31mExtracting $MPC_SRC\033[0;39m"
tar -xzvf $download_dir/$MPC_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$MPC_SRC; exit; }

echo -e "\033[1;31mExtracting $MPFR_SRC\033[0;39m"
tar -xjvf $download_dir/$MPFR_SRC.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$MPFR_SRC; exit; }

echo -e "\033[1;31mExtracting $EXPAT_SRC\033[0;39m"
tar -xzvf $download_dir/$EXPAT_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$EXPAT_SRC; exit; }

echo -e "\033[1;31mExtracting $MAKE_SRC\033[0;39m"
tar -xjvf $download_dir/$MAKE_SRC.tar.bz2 || { echo -e "\033[1;31mError extracting \033[0;39m"$MAKE_SRC; exit; }

echo -e "\033[1;31mExtracting $LIBELF_SRC\033[0;39m"
tar -xzvf $download_dir/$LIBELF_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$LIBELF_SRC; exit; }

echo -e "\033[1;31mExtracting $LIBTOOL_SRC\033[0;39m"
tar -xzvf $download_dir/$LIBTOOL_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$LIBTOOL_SRC; exit; }

echo -e "\033[1;31mExtracting $BASH_SRC\033[0;39m"
tar -xzvf $download_dir/$BASH_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$BASH_SRC; exit; }

echo -e "\033[1;31mExtracting $TAR_SRC\033[0;39m"
tar -xzvf $download_dir/$TAR_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$TAR_SRC; exit; }

echo -e "\033[1;31mExtracting $TEXINFO_SRC\033[0;39m"
tar -xzvf $download_dir/$TEXINFO_SRC.tar.gz || { echo -e "\033[1;31mError extracting \033[0;39m"$TEXINFO_SRC; exit; }

#---------------------------------------------------------------------------------
# Apply patches
#---------------------------------------------------------------------------------
#echo
#echo -e "\033[1;31mPatching $LESSTIF_SRC\033[0;39m"
#patch -p1 -d $LESSTIF_SRC < $top_dir/patches/$LESSTIF_SRC.patch || { echo -e "\033[1;31mError patching \033[0;39m"$LESSTIF_SRC; exit; }
#echo
