#!	/bin/bash

perl utilities/makefile-gen.pl .
source ~/bin/load-jlm.sh

# Datamining
cd datamining
cd correlation && make clean && make && cd ..
cd covariance && make clean && make && cd ..
cd ..

# Linear Algebra
cd linear-algebra
cd blas/gemm && make clean && make && cd ../..
cd blas/gemver && make clean && make && cd ../..
cd blas/gesummv && make clean && make && cd ../..
cd blas/symm && make clean && make && cd ../..
cd blas/syr2k && make clean && make && cd ../..
cd blas/syrk && make clean && make && cd ../..
cd blas/trmm && make clean && make && cd ../..

cd kernels/2mm && make clean && make && cd ../..
cd kernels/3mm && make clean && make && cd ../..
cd kernels/atax && make clean && make && cd ../..
cd kernels/bicg && make clean && make && cd ../..
cd kernels/doitgen && make clean && make && cd ../..
cd kernels/mvt && make clean && make && cd ../..

cd solvers/cholesky && make clean && make && cd ../..
cd solvers/durbin && make clean && make && cd ../..
cd solvers/gramschmidt && make clean && make && cd ../..
cd solvers/lu && make clean && make && cd ../..
cd solvers/ludcmp && make clean && make && cd ../..
cd solvers/trisolv && make clean && make && cd ../..
cd ..

# Medley
cd medley
cd deriche && make clean && make && cd ..
cd floyd-warshall && make clean && make && cd ..
cd nussinov && make clean && make && cd ..
cd ..

#Stencils
cd stencils
cd adi && make clean && make && cd ..
cd fdtd-2d && make clean && make && cd ..
cd heat-3d && make clean && make && cd ..
cd jacobi-1d && make clean && make && cd ..
cd jacobi-2d && make clean && make && cd ..
cd seidel-2d && make clean && make && cd ..
cd ..
