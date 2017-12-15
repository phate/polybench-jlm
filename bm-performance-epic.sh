#!  /bin/bash
#SBATCH --output=perf.out
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --partition=haswell
#SBATCH --exclusive
#SBATCH --mem=60000
#SBATCH -A p_readex

declare -a benchmarks=(
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

declare -a targets=(
	"OPTO0-LLCO0-stripped"
	"OPTO1-LLCO0-stripped"
	"OPTO2-LLCO0-stripped"
	"OPTO3-LLCO0-stripped"
	"OPTO3-no-vec-LLCO0-stripped"
	"gcc"
	"clang"
	"jlm-LLCO0")

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
echo "JLMFLAGS=$JLMFLAGS " >> config.mk
echo "OPTCFLAGS=$OPTCFLAGS" >> config.mk

#Compile targets
./compile_all.sh clean 1>&2
for target in "${targets[@]}"; do
	./compile_all.sh $target 1>&2
done

#Execute benchmarks and print timings
for i in $(seq 1 $NRUNS); do
    FILE=$OUTDIR/perf${i}.log

    #Print header
    echo "# $JLMFLAGS" > $FILE
		echo -n "# kernel " >> $FILE
		for target in "${targets[@]}"; do
			echo -n "$target " >> $FILE
		done
		echo "" >> $FILE

    for benchmark in "${benchmarks[@]}"; do
        BM=$(basename "${benchmark}")
        echo -n "$BM" >> $FILE

        for target in "${targets[@]}"; do
          TIME=$($benchmark-$target)
          echo -n " $TIME"
        done
        echo ""
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
