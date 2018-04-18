#!	/bin/bash

if [ -z "$JLMROOT" ]; then
	echo "JLMROOT variable not set."
	exit 1
fi

if [ -z "$JLMFLAGS" ]; then
	echo "JLMFLAGS variable not set."
	exit 1
fi

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
	"OPTO3-LLCO3"
	"OPTO3-no-vec-LLCO3"
	"OPTOs-LLCO3"
	"jlm-LLCO0"
	"jlm-no-unroll-LLCO3")

JIVEROOT=$JLMROOT/external/jive

make -C $JIVEROOT clean 1>&2
make -C $JIVEROOT -j4 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -g -DJIVE_DEBUG" 1>&2

make -C $JLMROOT clean 1>&2
make -C $JLMROOT -j4 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -g -DJLM_DEBUG -DJIVE_DEBUG" 1>&2

jlmflagsnounroll=`echo $JLMFLAGS | sed -e "s/--url//"`
export JLMFLAGSNOUNROLL=$jlmflagsnounroll
echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_TIME" >> config.mk

#Compile targets
./compile-target.sh clean 1>&2
for target in "${targets[@]}"; do
	./compile-target.sh $target 1>&2
done

#Print header
echo "# $jlmflags"
echo -n "# kernel "
for target in "${targets[@]}"; do
	echo -n "$target "
done
echo ""

#Execute benchmarks and print timings
for benchmark in "${benchmarks[@]}"; do
	BM=$(basename "${benchmark}")
	echo -n "$BM"

	for target in "${targets[@]}"; do
		SIZE=`size ${benchmark}-${target} | tail -1 | cut -f1 | xargs`
		echo -n " $SIZE"
	done
	echo ""
done
