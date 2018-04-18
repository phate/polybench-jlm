#!	/bin/bash

OPTFLAGS=`llvm-as < /dev/null | opt -O3 -disable-output -debug-pass=Arguments 2>&1 | awk '{if(NR==2)print}' | sed 's/Pass Arguments: //' | sed 's/-loop-vectorize //' | sed 's/-slp-vectorize //'`

export OPTCFLAGS=$OPTFLAGS
