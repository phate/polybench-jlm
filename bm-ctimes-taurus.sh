#!  /bin/bash

if [ "$#" -ne 2 ]; then
    echo "No output folder and # of experiments not specified."
    exit 1
fi
OUTDIR=$1
NRUNS=$2

if [ ! -d "$OUTDIR" ]; then
    echo "Folder $OUTDIR does not exist."
    exit 1
fi

if [ "$(ls -A $OUTDIR)" ]; then
    echo "Folder $OUTDIR is not empty."
    exit 1
fi

if [ "$NRUNS" -eq 0 ]; then
    echo "The number of experiments must be greater than zero."
    exit 1
fi

if [ -z "$JLMROOT" ]; then
	echo "JLMROOT variable not set."
	exit 1
fi

module purge 1>&2
module load gcc/6.3.0 1>&2

#Pin frequency
for n in {0..23}; do
    echo -n "userspace" > /sys/devices/system/cpu/cpu$n/cpufreq/scaling_governor
    echo -n "1200000" > /sys/devices/system/cpu/cpu$n/cpufreq/scaling_min_freq
    echo -n "1200000" > /sys/devices/system/cpu/cpu$n/cpufreq/scaling_max_freq

    FREQ=`cat /sys/devices/system/cpu/cpu$n/cpufreq/scaling_cur_freq`
    if [ "$FREQ" -ne 1200000 ]; then
        echo "Frequency pinning for CPU $n failed."
        exit 1
    fi
done

JIVEROOT=$JLMROOT/external/jive

OPTFLAGS=`cat optflags`
echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO" >> config.mk
echo "CFLAGS=-O0" >> config.mk
echo "OPTFLAGS=$OPTFLAGS" >> config.mk

make -C $JIVEROOT clean 1>&2
make -C $JIVEROOT -j4 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -O3" 1>&2

make -C $JLMROOT clean 1>&2
make -C $JLMROOT -j4 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -O3 -DRVSDGTIME" 1>&2

for i in $(seq 1 $NRUNS); do
    FILE=$OUTDIR/ctimes${i}.log
    ./compile_all.sh clean ct 2>&1 >/dev/null 2> $FILE
done

#Check frequency pinning
for n in {0..23}; do
    FREQ=`cat /sys/devices/system/cpu/cpu$n/cpufreq/scaling_cur_freq`
    if [ "$FREQ" -ne 1200000 ]; then
        echo "Frequency pinning for CPU $n not correct."
        exit 1
    fi
done

#Verify output
NLINES=`cat $OUTDIR/ctimes1.log | wc -l`
for i in $(seq 1 $NRUNS); do
    # Check number of lines in files
    NLINESI=`cat $OUTDIR/ctimes${i}.log | wc -l`
    if [ "$NLINES" -ne "$NLINESI" ]; then
        echo "Wrong number of lines in file: ctimes1.log vs. ctimes${i}.log."
        exit 1
    fi

    for l in $(seq 1 $NLINES); do
        LINE=`sed -n "${l}p" $OUTDIR/ctimes1.log`
        LINEL=`sed -n "${l}p" $OUTDIR/ctimes${i}.log`

        #Check number of columns for each line in files
        NCOLUMNS=`echo $LINEL | awk '{print NF}' | sort -nu | tail -n 1`
        if [ "$NCOLUMNS" -ne 4 ]; then
            echo "Wrong number of columns in line ${l} of file ctimes${i}.log."
            exit 1
        fi

        #Check equality of column 2
        CLM2=`echo ${LINE} | cut -d' ' -f2`
        CLML2=`echo ${LINEL} | cut -d' ' -f2`
        if [ "$CLM2" -ne "$CLML2" ]; then
            echo "Column 2 in line ${l} of file ctimes${i}.log are not equal: $CLM2 vs. $CLML2"
            exit 1
        fi

        #Check equality of column 3
        CLM3=`echo ${LINE} | cut -d' ' -f3`
        CLML3=`echo ${LINEL} | cut -d' ' -f3`
        if [ "$CLM3" -ne "$CLML3" ]; then
            echo "Column 3 in line ${l} of file ctimes${i}.log are not equal: $CLM3 vs. $CLML3"
            exit 1
        fi
    done
done