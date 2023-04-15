#!/bin/sh

# 
# MIPS GNU toolchain                                                       
#                                                                            

#---------------------------------------------------------------------------------
# Specify the version we will use
#---------------------------------------------------------------------------------
export GNU_TOOLCHAIN_VER=1.5.4

BASH_VER=4.1
BINUTILS_VER=2.21
export EXPAT_VER=2.0.1
export GCC_VER=4.5.2
GDB_VER=7.2
GMP_VER=5.0.1
LIBELF_VER=0.8.13
LIBTOOL_VER=2.2.10
MAKE_VER=3.82
MPC_VER=0.8.2
MPFR_VER=3.0.0
export NEWLIB_VER=1.19.0
TAR_VER=1.23
TEXINFO_VER=4.13

#---------------------------------------------------------------------------------
# Specify the source we will use
#---------------------------------------------------------------------------------
export GNU_TOOLCHAIN_INSTALL="gnu_toolchain-$GNU_TOOLCHAIN_VER"

export BASH_SRC="bash-$BASH_VER"
export BINUTILS_SRC="binutils-$BINUTILS_VER"
export EXPAT_SRC="expat-$EXPAT_VER"
export GCC_SRC="gcc-$GCC_VER"
GCC_CORE_SRC="gcc-core-$GCC_VER"
GCC_GPP_SRC="gcc-g++-$GCC_VER"
export GDB_SRC="gdb-$GDB_VER"
export GMP_SRC="gmp-$GMP_VER"
export LIBELF_SRC="libelf-$LIBELF_VER"
export LIBTOOL_SRC="libtool-$LIBTOOL_VER"
export MAKE_SRC="make-$MAKE_VER"
export MPC_SRC="mpc-$MPC_VER"
export MPFR_SRC="mpfr-$MPFR_VER"
export NEWLIB_SRC="newlib-$NEWLIB_VER"
export TAR_SRC="tar-$TAR_VER"
export TEXINFO_SRC="texinfo-$TEXINFO_VER"

#---------------------------------------------------------------------------------
# Specify the paths we will use
#---------------------------------------------------------------------------------
export MAKE=make
export target=mips-elf
export top_dir=$(pwd)
CPU=`uname -m`
OS=`uname -s`
if [ -n "$PREFIX" ]; then
  export prefix=$PREFIX/${GNU_TOOLCHAIN_INSTALL}-$OS-$CPU
  export addon_tools_dir=$PREFIX/addontools-${GNU_TOOLCHAIN_VER}-$OS-$CPU
else
  export prefix=$top_dir/output/${GNU_TOOLCHAIN_INSTALL}-$OS-$CPU
  export addon_tools_dir=$top_dir/output/addontools-${GNU_TOOLCHAIN_VER}-$OS-$CPU
fi
export scripts_dir=$top_dir
export work_dir=$top_dir/work
export download_dir=$top_dir/download

export PATH="$prefix/bin:$addon_tools_dir/bin:$PATH"
