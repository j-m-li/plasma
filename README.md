# Plasma - most MIPS I(TM) opcodes

https://opencores.org/projects/plasma

GNU GPL tools :

https://ftp.gnu.org/gnu/binutils/binutils-2.19.1.tar.gz

https://ftp.gnu.org/gnu/gcc/gcc-4.3.2.tar.gz

ftp://ftp.gnu.org/gnu/gmp/gmp-4.3.2.tar.gz

http://www.mpfr.org/mpfr-current/#download: mpfr-2.3.2.zip

Build binutils
```
   export TARGET=mips-elf
   export PREFIX=/usr/local/$TARGET
   export PREFIX=/home/username/gnu_mips/tools/$TARGET
   export PATH=$PATH:$PREFIX/bin
   ../binutils-2.19.1/configure --target=$TARGET --prefix=$PREFIX
```

Build GMP
```
   ../configure --prefix=$PREFIX
```

Build MPFR
```
   ../mpfr-2.3.2/configure -–target=$TARGET -–prefix=$PREFIX --with-gmp=$PREFIX
```

Build GCC
```
   ../gcc-4.3.2/configure --with-newlib --without-headers --enable-languages="c"  --target=$TARGET --prefix=$PREFIX --with-gnu-ld --with-gnu-as --disable-libssp  --with-mpfr=$PREFIX --with-gmp=$PREFIX
```

