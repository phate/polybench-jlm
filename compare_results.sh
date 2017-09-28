#!	/bin/bash

echo "CC=clang-3.7" > config.mk
echo "CPPFLAGS=-DPOLYBENCH_USE_C99_PROTO -DPOLYBENCH_DUMP_ARRAYS" >> config.mk
echo "CFLAGS=-O0" >> config.mk
echo "OPTFLAGS=" >> config.mk

./compile_all.sh

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

for kernel in "${kernels[@]}"; do
	echo -n "$kernel: "
	echo -n "run O2 "
	bash -c "$kernel-O2 2> /tmp/O2.log"
	echo -n "run jlm "
	bash -c "$kernel-jlm 2> /tmp/jlm.log"
	DIFF=$(diff /tmp/O2.log /tmp/jlm.log)
	if [ "$DIFF" != "" ]; then
		echo "$DIFF"
		exit;
	else
		echo "no differences."
	fi
	rm -rf /tmp/O2.log
	rm -rf /tmp/jlm.log
done
