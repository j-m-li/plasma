#!/bin/bash

#
# MIPS GNU toolchain
#

if [ -z "$1" ]; then 
  echo "Usage: $0 <install directory>"
  echo " "
  exit
fi
RUNDIR=$(pwd)
mkdir -p $1; cd $1
PREFIX=$(pwd)
cd $RUNDIR

#---------------------------------------------------------------------------------
# Call all scripts for compiling the toolchain
#---------------------------------------------------------------------------------
OS=`uname -s`
CPU=`uname -m`
if [ $OS = "Darwin" ]; then
  OS_OPTIONS=
elif [ $OS = "CYGWIN_NT-5.1" ]; then
  OS_OPTIONS=
elif [ $OS = "MINGW32_NT-5.1" ]; then
  OS_OPTIONS=
else
  OS_OPTIONS=
fi

. _env-only.sh

mkdir -p $work_dir
cd $work_dir

echo "Start of build:" > xx-temp.txt
date >> xx-temp.txt 

. $scripts_dir/00-set-env.sh

if [ $OS != "MINGW32_NT-5.1" ]; then
  $scripts_dir/01-build-stuff.sh || { echo -e "\033[1;31mError configuring stuff\033[0;39m"; exit 1; }
  $scripts_dir/02-build-make.sh || { echo -e "\033[1;31mError configuring make\033[0;39m"; exit 1; }
  $scripts_dir/03-build-libtool.sh || { echo -e "\033[1;31mError configuring libtool\033[0;39m"; exit 1; }
  $scripts_dir/04-build-texinfo.sh || { echo -e "\033[1;31mError configuring texinfo\033[0;39m"; exit 1; }
fi

$scripts_dir/05-build-libelf.sh || { echo -e "\033[1;31mError configuring libelf\033[0;39m"; exit 1; }
$scripts_dir/06-build-gmp.sh || { echo -e "\033[1;31mError configuring gmp\033[0;39m"; exit 1; }
$scripts_dir/07-build-mpfr.sh || { echo -e "\033[1;31mError configuring mpfr\033[0;39m"; exit 1; }
$scripts_dir/08-build-mpc.sh || { echo -e "\033[1;31mError configuring mpc\033[0;39m"; exit 1; }
#$scripts_dir/09-build-binutils.sh || { echo -e "\033[1;31mError configuring binutils\033[0;39m"; exit 1; }
#$scripts_dir/10-build-gcc.sh || { echo -e "\033[1;31mError configuring gcc\033[0;39m"; exit 1; }
$scripts_dir/11-build-binutils.sh || { echo -e "\033[1;31mError configuring binutils\033[0;39m"; exit 1; }
$scripts_dir/12-build-bootgcc.sh || { echo -e "\033[1;31mError configuring bootgcc\033[0;39m"; exit 1; }
$scripts_dir/13-build-newlib.sh || { echo -e "\033[1;31mError configuring newlib\033[0;39m"; exit 1; }
$scripts_dir/14-build-gcc.sh || { echo -e "\033[1;31mError configuring gcc\033[0;39m"; exit 1; }
$scripts_dir/15-build-expat.sh || { echo -e "\033[1;31mError configuring expat\033[0;39m"; exit 1; }
$scripts_dir/16-build-gdb.sh  || { echo -e "\033[1;31mError configuring gdb\033[0;39m"; exit 1; }
$scripts_dir/17-strip.sh  || { echo -e "\033[1;31mError configuring strip\033[0;39m"; exit 1; }

echo "End of build:" >> xx-temp.txt
date >> xx-temp.txt 
mv xx-temp.txt xx-ready.txt



