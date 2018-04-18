#!	/bin/bash

if [ -z "$JLMROOT" ]; then
	echo "JLMROOT variable not set."
	exit 1
fi

if [ -z "$JLMFLAGS" ]; then
	echo "JLMFLAGS variable not set."
	exit 1
fi

JIVEROOT=$JLMROOT/external/jive

echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO" >> config.mk
echo "CFLAGS=-O0" >> config.mk

make -C $JIVEROOT clean 1>&2
make -C $JIVEROOT -j4 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -O3" 1>&2

make -C $JLMROOT clean 1>&2
make -C $JLMROOT -j4 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -O3 -DRVSDGTIME" 1>&2

./compile-target.sh clean jlm-LLCO3 2>&1 >/dev/null
