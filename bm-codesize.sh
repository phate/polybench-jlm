#!	/bin/bash

if [ -z "$JLMROOT" ]; then
	echo "JLMROOT variable not set."
	exit 1
fi

JIVEROOT=$JLMROOT/external/jive

make -C $JIVEROOT clean 1>&2
make -C $JIVEROOT -j4 CFLAGS="-Wall --std=c++14 -xc++ -Wfatal-errors -g -DJIVE_DEBUG" 1>&2

make -C $JLMROOT clean 1>&2
make -C $JLMROOT -j4 CXXFLAGS="-Wall --std=c++14 -Wfatal-errors -g -DJLM_DEBUG -DJIVE_DEBUG" 1>&2

optflags=`cat optflags`
echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_TIME" >> config.mk
echo "CFLAGS=-O0" >> config.mk
echo "OPTFLAGS=$optflags" >> config.mk

./compile_all.sh clean Os O2 jlm 1>&2

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


echo "# $optflags"
echo "# kernel Os O2 JLM"
for kernel in "${kernels[@]}"; do
	BASENAME=$(basename "${kernel}")
	echo -n "$BASENAME "

	OsSIZE=`size $kernel-Os | tail +2 | cut -f1 | xargs`
	echo -n "$OsSIZE "

	O2SIZE=`size $kernel-O2 | tail +2 | cut -f1 | xargs`
	echo -n "$O2SIZE "

	JLMSIZE=`size $kernel-jlm | tail +2 | cut -f1 | xargs`
	echo "$JLMSIZE"
done
