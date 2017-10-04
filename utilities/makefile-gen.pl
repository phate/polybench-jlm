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

all: $kernel-O2 $kernel-O1 $kernel-O0 $kernel-jlm

$kernel-jlm: $kernel.c $kernel.h
	\${VERBOSE} clang-3.7 -S -emit-llvm $kernel.c \${CFLAGS} \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	opt-3.7 -mem2reg -S $kernel.ll > $kernel-opt.ll
	jlm-opt \${OPTFLAGS} --xml $kernel-opt.ll > $kernel-jlm.rvsdg
	jlm-opt \${OPTFLAGS} --llvm $kernel-opt.ll > $kernel-jlm.ll
	jlm-opt --llvm polybench.ll > polybench-jlm.ll
	llc-3.7 -O0 -filetype=obj -o $kernel-jlm.o $kernel-jlm.ll
	llc-3.7 -O0 -filetype=obj -o polybench-jlm.o polybench-jlm.ll
	\${VERBOSE} clang-3.7 \${CFLAGS} \${CPPFLAGS} -o $kernel-jlm $kernel-jlm.o polybench-jlm.o \${EXTRA_FLAGS}

$kernel-O0: $kernel.c $kernel.h
	\${VERBOSE} \${CC} -o $kernel-O0 $kernel.c -O0 \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c \${EXTRA_FLAGS}

$kernel-O1: $kernel.c $kernel.h
	\${VERBOSE} \${CC} -o $kernel-O1 $kernel.c -O1 \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c \${EXTRA_FLAGS}

$kernel-O2: $kernel.c $kernel.h
	\${VERBOSE} \${CC} -O2 -S -emit-llvm $kernel.c \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c
	mv $kernel.ll $kernel-O2.ll
	\${VERBOSE} \${CC} -o $kernel-O2 $kernel.c -O2 \${CPPFLAGS} -I. -I$utilityDir $utilityDir/polybench.c \${EXTRA_FLAGS}


clean:
	@ rm -f $kernel-O0
	@ rm -f $kernel-O1
	@ rm -f $kernel-O2
	@ rm -f $kernel-jlm
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
CC=clang-3.7
CPPFLAGS= -DPOLYBENCH_DUMP_ARRAYS -DPOLYBENCH_USE_C99_PROTO
CFLAGS=-O0
EOF

close FILE;

}

