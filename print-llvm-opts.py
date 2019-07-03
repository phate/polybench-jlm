#!/usr/bin/python

import os
import sys

def main():
	opts = os.popen(
		'llvm-as-7 < /dev/null | opt-7 -O3 -disable-output -debug-pass=Arguments 2>&1').read().split()

	###
	# Remove help text
	###
	opts = [opt for opt in opts if opt != "Pass" and opt != "Arguments:"]

	for opt in opts:
		sys.stdout.write(" -V"+opt)

if __name__ == "__main__":
	main()
