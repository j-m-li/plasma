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
. _env-only.sh

#---------------------------------------------------------------------------------
# Download source packages
#---------------------------------------------------------------------------------
wget -P $download_dir http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VER.tar.bz2
wget -P $download_dir http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VER/$GCC_CORE_SRC.tar.bz2
wget -P $download_dir http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VER/$GCC_GPP_SRC.tar.bz2
wget -P $download_dir ftp://sources.redhat.com/pub/newlib/$NEWLIB_SRC.tar.gz
wget -P $download_dir http://ftp.gnu.org/gnu/gdb/$GDB_SRC.tar.bz2
wget -P $download_dir http://ftp.gnu.org/gnu/gmp/$GMP_SRC.tar.bz2
wget -P $download_dir http://ftp.gnu.org/gnu/mpfr/$MPFR_SRC.tar.bz2
wget -P $download_dir http://www.multiprecision.org/mpc/download/$MPC_SRC.tar.gz
wget -P $download_dir http://sourceforge.net/projects/expat/files/expat/$EXPAT_VER/$EXPAT_SRC.tar.gz/download
wget -P $download_dir http://ftp.gnu.org/gnu/make/$MAKE_SRC.tar.bz2
wget -P $download_dir http://www.mr511.de/software/$LIBELF_SRC.tar.gz
wget -P $download_dir http://ftp.gnu.org/gnu/libtool/$LIBTOOL_SRC.tar.gz
wget -P $download_dir http://ftp.gnu.org/gnu/bash/$BASH_SRC.tar.gz
wget -P $download_dir http://ftp.gnu.org/gnu/tar/$TAR_SRC.tar.gz
wget -P $download_dir http://ftp.gnu.org/gnu/texinfo/$TEXINFO_SRC.tar.gz
