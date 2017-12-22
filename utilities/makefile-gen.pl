#!/usr/bin/perl

# Generates Makefile for each benchmark in polybench
# Expects to be executed from root folder of polybench
#
# Written by Tomofumi Yuki, 11/21 2014
#

my $GEN_CONFIG = 0;
my $TARGET_DIR = ".";

if ($#ARGV !=0 && $#ARGV != 1) {
   printf("usage perl makefile-gen.pl output-dir [-cfg]\n");
   printf("  -cfg option generates config.mk in the output-dir.\n");
   exit(1);
}



foreach my $arg (@ARGV) {
   if ($arg =~ /-cfg/) {
      $GEN_CONFIG = 1;
   } elsif (!($arg =~ /^-/)) {
      $TARGET_DIR = $arg;
   }
}


my %categories = (
   'linear-algebra/blas' => 3,
   'linear-algebra/kernels' => 3,
   'linear-algebra/solvers' => 3,
   'datamining' => 2,
   'stencils' => 2,
   'medley' => 2
);

my %extra_flags = (
   'deriche' => '-lm',
   'cholesky' => '-lm',
   'gramschmidt' => '-lm',
   'correlation' => '-lm'
);

foreach $key (keys %categories) {
   my $target = $TARGET_DIR.'/'.$key;
   opendir DIR, $target or die "directory $target not found.\n";
   while (my $dir = readdir DIR) {
        next if ($dir=~'^\..*');
        next if (!(-d $target.'/'.$dir));

	my $kernel = $dir;
        my $file = $target.'/'.$dir.'/Makefile';
        my $polybenchRoot = '../'x$categories{$key};
        my $configFile = $polybenchRoot.'config.mk';
        my $utilityDir = $polybenchRoot.'utilities';

        open FILE, ">$file" or die "failed to open $file.";

print FILE << "EOF";
include $configFile

EXTRA_FLAGS=$extra_flags{$kernel}

all:	OPTO0-LLCO0 \\
			OPTO0-LLCO3 \\
			OPTO0-LLCO0-stripped \\
			OPTO0-LLCO3-stripped \\
			\\
			OPTO1-LLCO0 \\
			OPTO1-LLCO3 \\
			OPTO1-LLCO0-stripped \\
			OPTO1-LLCO3-stripped \\
			\\
			OPTO2-LLCO0 \\
			OPTO2-LLCO3 \\
			OPTO2-LLCO0-stripped \\
			OPTO2-LLCO3-stripped \\
			\\
			OPTO3-LLCO0 \\
			OPTO3-LLCO3 \\
			OPTO3-LLCO0-stripped \\
			OPTO3-LLCO3-stripped \\
			\\
			OPTO3-no-vec-LLCO0 \\
			OPTO3-no-vec-LLCO3 \\
			OPTO3-no-vec-LLCO0-stripped \\
			OPTO3-no-vec-LLCO3-stripped \\
			\\
			OPTOs-LLCO0 \\
			OPTOs-LLCO3 \\
			OPTOs-LLCO0-stripped \\
			OPTOs-LLCO3-stripped \\
			\\
			jlm-LLCO0 \\
			jlm-LLCO3 \\
			\\
			jlm-no-unroll
			clang \\
			gcc \\

jlm-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling jlm-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	jlm-opt \${JLMFLAGS} --xml $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.rvsdg
	jlm-opt \${JLMFLAGS} --llvm $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

jlm-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling jlm-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	jlm-opt \${JLMFLAGS} --xml $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.rvsdg
	jlm-opt \${JLMFLAGS} --llvm $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

gcc: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling gcc:"
	\${VERBOSE} gcc -O3 \${CPPFLAGS} -I. -I$utilityDir -o $kernel-\${@} $kernel.c $utilityDir/polybench.c \${EXTRA_FLAGS}

clang: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling clang:"
	\${VERBOSE} clang -O3 \${CPPFLAGS} -I. -I$utilityDir -o $kernel-\${@} $kernel.c $utilityDir/polybench.c \${EXTRA_FLAGS}
	\${VERBOSE} clang -O3 \${CPPFLAGS} -I. -I$utilityDir -S -emit-llvm -o $kernel-\${@}.ll $kernel.c

jlm-no-unroll-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling jlm-no-unroll:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	jlm-opt \${JLMFLAGSNOUNROLL} --xml $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.rvsdg
	jlm-opt \${JLMFLAGSNOUNROLL} --llvm $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO0-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO0-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	cp $kernel-\${@}-opt.ll $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO0-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO0-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	cp $kernel-\${@}-opt.ll $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO0-LLCO0-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO0-LLCO0-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	cp $kernel-\${@}-opt-rmd.ll $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO0-LLCO3-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO0-LLCO3-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	cp $kernel-\${@}-opt-rmd.ll $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO1-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO1-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -O1 -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO1-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO1-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -O1 -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO1-LLCO0-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO1-LLCO0-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -O1 -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO1-LLCO3-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO1-LLCO3-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -O1 -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO2-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO2-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -O2 -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO2-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO2-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -O2 -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO2-LLCO0-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO2-LLCO0-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -O2 -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO2-LLCO3-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO2-LLCO3-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -O2 -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -O3 -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -O3 -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-LLCO0-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-LLCO0-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -O3 -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-LLCO3-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-LLCO3-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -O3 -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTOs-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTOs-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -Os -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTOs-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTOs-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt -Os -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTOs-LLCO0-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTOs-LLCO0-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -Os -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTOs-LLCO3-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTOs-LLCO3-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt -Os -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-no-vec-LLCO0: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-no-vec-LLCO0:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt \${OPTCFLAGS} -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-no-vec-LLCO3: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-no-vec-LLCO3:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c

	opt -mem2reg -S $kernel.ll > $kernel-\${@}-opt.ll

	opt \${OPTCFLAGS} -S $kernel-\${@}-opt.ll > $kernel-\${@}.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-no-vec-LLCO0-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-no-vec-LLCO0-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt \${OPTCFLAGS} -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O0 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

OPTO3-no-vec-LLCO3-stripped: $kernel.c $kernel.h
	@ echo ""
	@ echo "Compiling OPTO3-no-vec-LLCO3-stripped:"
	\${VERBOSE} clang -O0 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	python $utilityDir/remove-metadata.py $kernel.ll > $kernel-\${@}-rmd.ll

	opt -mem2reg -S $kernel-\${@}-rmd.ll > $kernel-\${@}-opt.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}-opt.ll > $kernel-\${@}-opt-rmd.ll

	opt \${OPTCFLAGS} -S $kernel-\${@}-opt-rmd.ll > $kernel-\${@}.ll
	python $utilityDir/remove-metadata.py $kernel-\${@}.ll > $kernel-\${@}-rmd.ll

	llc -O3 -filetype=obj -o $kernel-\${@}.o $kernel-\${@}-rmd.ll
	llc -O0 -filetype=obj -o polybench.o polybench.ll
	\${VERBOSE} clang -O0 \${CPPFLAGS} -o $kernel-\${@} $kernel-\${@}.o polybench.o \${EXTRA_FLAGS}

clean:
	@ rm -f $kernel-OPTO0-LLCO0
	@ rm -f $kernel-OPTO0-LLCO3
	@ rm -f $kernel-OPTO0-LLCO0-stripped
	@ rm -f $kernel-OPTO0-LLCO3-stripped

	@ rm -f $kernel-OPTO1-LLCO0
	@ rm -f $kernel-OPTO1-LLCO3
	@ rm -f $kernel-OPTO1-LLCO0-stripped
	@ rm -f $kernel-OPTO1-LLCO3-stripped

	@ rm -f $kernel-OPTO2-LLCO0
	@ rm -f $kernel-OPTO2-LLCO3
	@ rm -f $kernel-OPTO2-LLCO0-stripped
	@ rm -f $kernel-OPTO2-LLCO3-stripped

	@ rm -f $kernel-OPTO3-LLCO0
	@ rm -f $kernel-OPTO3-LLCO3
	@ rm -f $kernel-OPTO3-LLCO0-stripped
	@ rm -f $kernel-OPTO3-LLCO3-stripped

	@ rm -f $kernel-OPTOs-LLCO0
	@ rm -f $kernel-OPTOs-LLCO3
	@ rm -f $kernel-OPTOs-LLCO0-stripped
	@ rm -f $kernel-OPTOs-LLCO3-stripped

	@ rm -f $kernel-OPTO3-no-vec-LLCO0
	@ rm -f $kernel-OPTO3-no-vec-LLCO3
	@ rm -f $kernel-OPTO3-no-vec-LLCO0-stripped
	@ rm -f $kernel-OPTO3-no-vec-LLCO3-stripped

	@ rm -f $kernel-jlm-LLCO0
	@ rm -f $kernel-jlm-LLCO3

	@ rm -f $kernel-gcc
	@ rm -f $kernel-clang
	@ rm -f $kernel-jlm-no-unroll
	@ rm -f *.rvsdg
	@ rm -f *.ll
	@ rm -f *.o

EOF

        close FILE;
   }


   closedir DIR;
}

if ($GEN_CONFIG) {
open FILE, '>'.$TARGET_DIR.'/config.mk';

print FILE << "EOF";
CC=clang
CPPFLAGS= -DPOLYBENCH_DUMP_ARRAYS -DPOLYBENCH_USE_C99_PROTO
EOF

close FILE;

}

