#!/bin/sh
DATESTRING=$(date +%Y)$(date +%m)$(date +%d)
#tar --exclude=*.bz2 --exclude=*.gz --exclude=install\* -cvjf build-scripts-$DATESTRING.tar.bz2 *
tar -cvjf build-scripts-$DATESTRING.tar.bz2 *.sh download/README.TXT gpl.txt patches README.TXT
