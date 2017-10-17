#!	/bin/bash

perl utilities/makefile-gen.pl .
source ~/bin/load-jlm.sh

# Datamining
make -C datamining/correlation clean all
make -C datamining/covariance clean all

# Linear Algebra
make -C linear-algebra/blas/gemm clean all
make -C linear-algebra/blas/gemver clean all
make -C linear-algebra/blas/gesummv clean all
make -C linear-algebra/blas/symm clean all
make -C linear-algebra/blas/syr2k clean all
make -C linear-algebra/blas/syrk clean all
make -C linear-algebra/blas/trmm clean all

make -C linear-algebra/kernels/2mm clean all
make -C linear-algebra/kernels/3mm clean all
make -C linear-algebra/kernels/atax clean all
make -C linear-algebra/kernels/bicg clean all
make -C linear-algebra/kernels/doitgen make all
make -C linear-algebra/kernels/mvt clean all

make -C linear-algebra/solvers/cholesky clean all
make -C linear-algebra/solvers/durbin clean all
make -C linear-algebra/solvers/gramschmidt clean all
make -C linear-algebra/solvers/lu clean all
make -C linear-algebra/solvers/ludcmp clean all
make -C linear-algebra/solvers/trisolv clean all

# Medley
make -C medley/deriche clean all
make -C medley/floyd-warshall clean all
make -C medley/nussinov clean all

#Stencils
make -C stencils/adi clean all
make -C stencils/fdtd-2d clean all
make -C stencils/head-3d clean all
make -C stencils/jacobi-1d clean all
make -C stencils/jacobi-2d clean all
make -C stencils/seidel-2d clean all
