#!	/bin/bash

if [ -z "$JLMROOT" ]; then
	echo "JLMROOT variable not set."
	exit 1
fi

JIVEROOT=$JLMROOT/external/jive

OPTFLAGS=`cat optflags`
echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO" >> config.mk
echo "CFLAGS=-O0" >> config.mk
echo "OPTFLAGS=$OPTFLAGS" >> config.mk

OPTTIMES=""
IFS=' ' read -ra OPTARRAY <<< "$OPTFLAGS"
for OPT in "${OPTARRAY[@]}"; do
	OPTTIME=`echo "$OPT" | cut -c 3- | awk '{print toupper($0)}'`
	OPTTIMES+="-D${OPTTIME}TIME "
done

make -C $JIVEROOT clean
make -C $JIVEROOT -j4 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -O2"

make -C $JLMROOT clean
make -C $JLMROOT -j4 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -O2 $OPTTIMES"

./compile_all.sh clean ct
