#!	/bin/bash

if [ "$#" -eq 0 ]; then
	echo "No make targets specified."
	exit 1
fi

TARGETS=""
for TARGET in "$@"; do
	TARGETS+=" $TARGET"
done

perl utilities/makefile-gen.pl .
source ~/bin/load-jlm.sh

# Datamining
make -C datamining/correlation $TARGETS
make -C datamining/covariance $TARGETS

# Linear Algebra
make -C linear-algebra/blas/gemm $TARGETS
make -C linear-algebra/blas/gemver $TARGETS
make -C linear-algebra/blas/gesummv $TARGETS
make -C linear-algebra/blas/symm $TARGETS
make -C linear-algebra/blas/syr2k $TARGETS
make -C linear-algebra/blas/syrk $TARGETS
make -C linear-algebra/blas/trmm $TARGETS

make -C linear-algebra/kernels/2mm $TARGETS
make -C linear-algebra/kernels/3mm $TARGETS
make -C linear-algebra/kernels/atax $TARGETS
make -C linear-algebra/kernels/bicg $TARGETS
make -C linear-algebra/kernels/doitgen $TARGETS
make -C linear-algebra/kernels/mvt $TARGETS

make -C linear-algebra/solvers/cholesky $TARGETS
make -C linear-algebra/solvers/durbin $TARGETS
make -C linear-algebra/solvers/gramschmidt $TARGETS
make -C linear-algebra/solvers/lu $TARGETS
make -C linear-algebra/solvers/ludcmp $TARGETS
make -C linear-algebra/solvers/trisolv $TARGETS

# Medley
make -C medley/deriche $TARGETS
make -C medley/floyd-warshall $TARGETS
make -C medley/nussinov $TARGETS

#Stencils
make -C stencils/adi $TARGETS
make -C stencils/fdtd-2d $TARGETS
make -C stencils/heat-3d $TARGETS
make -C stencils/jacobi-1d $TARGETS
make -C stencils/jacobi-2d $TARGETS
make -C stencils/seidel-2d $TARGETS
