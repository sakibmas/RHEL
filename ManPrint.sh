#!/bin/bash
cmd=$1
man -t $cmd > $cmd.ps
if [ $? == 0 ];
then
 echo manual available
 ps2pdf $cmd.ps
 rm -f $cmd.ps
else
 $cmd --help > $cmd.txt
 vim $cmd.txt -c "hardcopy > $cmd.ps | q"
 ps2pdf $cmd.ps
 rm -f $cmd.txt $cmd.ps
fi
