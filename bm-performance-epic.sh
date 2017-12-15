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

JIVEROOT=$JLMROOT/external/jive

make -C $JIVEROOT clean 1>&2
make -C $JIVEROOT -j4 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -g -DJIVE_DEBUG" 1>&2

make -C $JLMROOT clean 1>&2
make -C $JLMROOT -j4 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -g -DJLM_DEBUG -DJIVE_DEBUG" 1>&2

JLMFLAGS=`cat jlmflags`
OPTCFLAGS=`cat optcflags | tr '\n' ' '`
echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_TIME" >> config.mk
echo "CFLAGS=-O0" >> config.mk
echo "JLMFLAGS=$JLMFLAGS " >> config.mk
echo "OPTCFLAGS=$OPTCFLAGS" >> config.mk

./compile_all.sh clean O0 O1 O2 O3 O3-no-vec jlm 1>&2

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

    echo "# $JLMFLAGS" > $FILE
    echo "# kernel O0 O1 O2 O3 O3-no-vec JLM" >> $FILE
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

        O3NOVECTIME=$($kernel-O3-no-vec)
        echo -n " $O3NOVECTIME" >> $FILE

        JLMTIME=$($kernel-jlm)
        echo " $JLMTIME" >> $FILE
    done
done

#Verify output
NLINES=`cat $OUTDIR/perf1.log | wc -l`
for i in $(seq 1 $NRUNS); do
    # Check number of lines in files
    NLINESI=`cat $OUTDIR/perf${i}.log | wc -l`
    if [ "$NLINES" -ne "$NLINESI" ]; then
        echo "Wrong number of lines in file: perf1.log vs. perf${i}.log."
        exit 1
    fi

    for l in $(seq 1 $NLINES); do
        LINE=`sed -n "${l}p" $OUTDIR/perf1.log`
        LINEL=`sed -n "${l}p" $OUTDIR/perf${i}.log`

        #Check number of columns for each line in files
        NCOLUMNS=`echo $LINEL | awk '{print NF}' | sort -nu | tail -n 1`
        if [ "$NCOLUMNS" -ne 7 ]; then
            echo "Wrong number of columns in line ${l} of file perf${i}.log."
            exit 1
        fi
    done
done
