#!  /bin/bash
#SBATCH --output=perf.out
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --partition=haswell
#SBATCH --exclusive
#SBATCH --mem=60000
#SBATCH -A p_readex

if [ "$#" -ne 2 ]; then
    echo "No output folder and # of experiments not specified."
    exit 1
fi
OUTDIR=$1
NRUNS=$2

JLMROOT=/home/nreissma/rvsdg/jlm
export PATH=$JLMROOT:$PATH

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

JIVEROOT=$JLMROOT/external/jive

make -C $JIVEROOT clean 1>&2
make -C $JIVEROOT -j24 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -g -DJIVE_DEBUG" 1>&2

make -C $JLMROOT clean 1>&2
make -C $JLMROOT -j24 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -g -DJLM_DEBUG -DJIVE_DEBUG" 1>&2

optflags=`cat optflags`
echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_TIME" >> config.mk
echo "CFLAGS=-O0" >> config.mk
echo "OPTFLAGS=$optflags" >> config.mk

./compile_all.sh clean O0 O1 O2 O3 optc jlm 1>&2

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

declare -a kernels=(
	"datamining/correlation/correlation"
	"datamining/covariance/covariance"
	"linear-algebra/blas/gemm/gemm"
	"linear-algebra/blas/gemver/gemver"
	"linear-algebra/blas/gesummv/gesummv"
	"linear-algebra/blas/symm/symm"
	"linear-algebra/blas/syr2k/syr2k"
	"linear-algebra/blas/syrk/syrk"
	"linear-algebra/blas/trmm/trmm"
	"linear-algebra/kernels/2mm/2mm"
	"linear-algebra/kernels/3mm/3mm"
	"linear-algebra/kernels/atax/atax"
	"linear-algebra/kernels/bicg/bicg"
	"linear-algebra/kernels/doitgen/doitgen"
	"linear-algebra/kernels/mvt/mvt"
	"linear-algebra/solvers/cholesky/cholesky"
	"linear-algebra/solvers/durbin/durbin"
	"linear-algebra/solvers/gramschmidt/gramschmidt"
	"linear-algebra/solvers/lu/lu"
	"linear-algebra/solvers/ludcmp/ludcmp"
	"linear-algebra/solvers/trisolv/trisolv"
	"medley/deriche/deriche"
	"medley/floyd-warshall/floyd-warshall"
	"medley/nussinov/nussinov"
	"stencils/adi/adi"
	"stencils/fdtd-2d/fdtd-2d"
	"stencils/heat-3d/heat-3d"
	"stencils/jacobi-1d/jacobi-1d"
	"stencils/jacobi-2d/jacobi-2d"
	"stencils/seidel-2d/seidel-2d")

for i in $(seq 1 $NRUNS); do
    FILE=$OUTDIR/perf${i}.log

    echo "# $optflags" > $FILE
    echo "# kernel O0 O1 O2 O3 OPTC JLM" >> $FILE
    for kernel in "${kernels[@]}"; do
        echo -n "$kernel" >> $FILE

        O0TIME=$($kernel-O0)
        echo -n " $O0TIME" >> $FILE

        O1TIME=$($kernel-O1)
        echo -n " $O1TIME" >> $FILE

        O2TIME=$($kernel-O2)
        echo -n " $O2TIME" >> $FILE

        O3TIME=$($kernel-O3)
        echo -n " $O3TIME" >> $FILE

        OPTCTIME=$($kernel-optc)
        echo -n "$OPTCTIME "

        JLMTIME=$($kernel-jlm)
        echo " $JLMTIME" >> $FILE
    done
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
        if [ "$NCOLUMNS" -ne 6 ]; then
            echo "Wrong number of columns in line ${l} of file ctimes${i}.log."
            exit 1
        fi
    done
done
