#!/usr/bin/env bash

# 
# MIPS GNU toolchain                                                       
#                                                                            

set -o pipefail

#---------------------------------------------------------------------------------
# strip binaries
# strip has trouble using wildcards so do it this way instead
#---------------------------------------------------------------------------------

echo "Start of build:" > 17-temp.txt
date >> 17-temp.txt 


for f in \
	$prefix/bin/* \
	$prefix/$target/bin/* \
	$prefix/libexec/gcc/$target/$GCC_VER/*
do
	strip $f
done


echo "End of build:" >> 17-temp.txt
date >> 17-temp.txt 
mv 17-temp.txt 17-ready.txt



