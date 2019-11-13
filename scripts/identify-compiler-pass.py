#!/usr/bin/python

# This scripts can be used to identify which compiler pass that improves
# performance. The script relies on the OPTO3-no-vec-LLCO3 compilation target
# to manually pass on the compilation passes to use.
# The scripts removes one pass at a time from the last towards the first.
#
# ASSUMPTIONS
# The scripts assumes that a single benchmark will be compiled and run so 
# all but one benchmark has to be commented out in Makefile.sub.
# Furthermore, the BENCHMARK_OUTPUT has to be manually set to read the correct
# output.
# The script needs to be executed from the root of polybench

import os
import sys
import subprocess

#BENCHMARK_OUTPUT = "floyd-warshall-OPTO3-no-vec-LLCO3-time.txt"
BENCHMARK_OUTPUT = "nussinov-OPTO3-no-vec-LLCO3-time.txt"
#BENCHMARK_OUTPUT = "syrk-OPTO3-no-vec-LLCO3-time.txt"
#BENCHMARK_OUTPUT = "adi-OPTO3-no-vec-LLCO3-time.txt"
#BENCHMARK_OUTPUT = "seidel-2d-OPTO3-no-vec-LLCO3-time.txt"
TARGET = "OPTO3-no-vec-LLCO3"

def main():
	# Get all optimizations passes
	ALL_OPTS = os.popen("./scripts/print-llvm-opts.py").read().split()

	# Without vecoritzation
	#ALL_OPTS = os.popen("./print-llvm-opts.py  | sed 's/-V-loop-vectorize //' | sed 's/-V-slp-vectorize //'").read().split()

	# Iterate backwords removing one option at a time
	for n in range(len(ALL_OPTS)-1, 0, -1):
		first_NO_VEC = ALL_OPTS[0:n:1]
		last_NO_VEC = ALL_OPTS[n:]
		#print n
		#print first_NO_VEC
		#print last_NO_VEC
		NO_VEC = first_NO_VEC
		#print NO_VEC

		command = "NO_VEC='" + ' '.join(NO_VEC) + "' make polybench-time TARGET=OPTO3-no-vec-LLCO3"
		#print command
		os.popen(command).read()

		result_file = open("./results/" + BENCHMARK_OUTPUT, "r") 
		sys.stdout.write(str(n) + ": " + ' '.join(last_NO_VEC) + ": " + result_file.read())
		sys.stdout.flush()
		#print str(n) + ": " + opt + ": " + result_file.read() 
		result_file.close()

if __name__ == "__main__":
        main()
