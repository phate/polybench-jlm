#!/usr/bin/python

import argparse
import copy
import os
import subprocess as sp
import sys

class Command(object):
	def __init__(self, cmd, args):
		self._cmd = cmd
		self._args = args
		self._ifile = ""

	def __str__(self):
		return " ".join([self._cmd] + self._args + ["-o", self.ofile()] + [self.ifile()])

	def append_args(self, args):
		self._args += args

	def ifile(self):
		return self._ifile

	def set_ifile(self, name):
		self._ifile = name

	def ofile(self):
		return ""

	def cmd(self):
		return self._cmd

	def run(self):
		child = sp.Popen([self._cmd] + self._args + ["-o", self.ofile()] + [self.ifile()],
			stdout=sp.PIPE, stderr=sp.PIPE)
		stdout, stderr = child.communicate()
		return (child.returncode, stdout, stderr)


class CommandList(object):
	def __init__(self, cmds):
		self._cmds = cmds

	def __str__(self):
		return "\n".join([str(cmd) for cmd in self._cmds])

	def run(self):
		stdout = []
		for cmd in self._cmds:
			code, out, err = cmd.run()
			stdout += out
			if code != 0:
				sys.stderr.write(err)
				return stdout
		return "".join(stdout)

	def append(self, cmds):
		if isinstance(cmds, CommandList):
			self._cmds += cmds._cmds
		else:
			self._cmds.append(cmds)
		return self

	def __add__(self, other):
		return self.append(other)

	def __iter__(self):
		return self._cmds.__iter__()


def filename(filepath):
	return os.path.splitext(filepath)[0]

class clang(Command):
	def __init__(self, args):
		super(clang, self).__init__("clang-7", args)

	def ofile(self):
		return filename(self._ifile) + ".ll"

class mem2reg(Command):
	def __init__(self, args):
		super(mem2reg, self).__init__("opt-7", ["-mem2reg", "-S"])

	def ofile(self):
		return filename(self._ifile) + "-mem2reg.ll"

class llvm_opt(Command):
	def __init__(self, args):
		super(llvm_opt, self).__init__("opt-7", args)

	def ofile(self):
		return filename(self._ifile) + "-llvmopt.ll"

class llvm_strip(Command):
	def __init__(self, args):
		super(llvm_strip, self).__init__("llvm-strip", args)

	def ofile(self):
		return filename(self._ifile) + "-stripped.ll"

class llc(Command):
	def __init__(self, args):
		super(llc, self).__init__("llc-7", args)

	def ofile(self):
		return filename(self._ifile) + ".o"

class jlm_opt(Command):
	def __init__(self, args):
		super(jlm_opt, self).__init__("jlm-opt", args)

	def ofile(self):
		return filename(self._ifile) + "-jlmopt.ll"

class lnk(Command):
	def __init__(self, args, objctfiles, ofile):
		super(lnk, self).__init__("clang", ["-O0"] + objctfiles + args)
		self._ofile = ofile

	def ofile(self):
		return self._ofile


pipelines = {
		"jlm-LLC" : CommandList([
			clang(["-O0", "-S", "-emit-llvm"])
		, llvm_strip([])
		, mem2reg([])
		, llvm_strip([])
		, jlm_opt([])
		, llc(["-filetype=obj"])
		])
	, "opt-LLC" : CommandList([
	    clang(["-O0", "-S", "-emit-llvm"])
	  , llvm_strip([])
	  , mem2reg([])
	  , llvm_strip([])
	  , llvm_opt(["-S"])
	  , llvm_strip([])
	  , llc(["-filetype=obj"])
	  ])
}


parser = argparse.ArgumentParser(description="Simple compilation driver.")
parser.add_argument(
	  'pipeline'
	, choices=['jlm-LLC', 'opt-LLC']
	, help="Compilation pipeline")
parser.add_argument(
	  'LLCOlvl'
	, choices=['LLCO0', 'LLCO1', 'LLCO2', 'LLCO3']
	, help="LLC optimization level")
parser.add_argument(
	  '-J'
	, action='append'
	, dest='jlmoptflags'
	, choices=['cne', 'dne', 'iln', 'inv', 'psh', 'pll', 'red', 'ivt', 'url']
	, help='JLM optimization flags.')
parser.add_argument(
	  'files'
	, nargs='+'
	, metavar='<files>')
parser.add_argument(
	  '-I'
	, action='append'
	, dest='includes'
	, metavar='<dir>'
	, help='Add directory <dir> to include search paths.')
parser.add_argument(
	  '-l'
	, action='append'
	, dest='libs'
	, metavar='<lib>'
	, help='Search library <lib> when linking.')
parser.add_argument(
	  '-D'
	, action='append'
	, dest='macros'
	, metavar='<macro>'
	, help='Add <macro> to preprocessor macros.')
parser.add_argument(
	  '-V'
	, action='append'
	, dest='indvllvmoptflags'
	, metavar='<optimization>'
	, help="Add individual LLVM optimization flag.")
parser.add_argument(
	  '-O'
	, action='store'
	, dest='llvmoptflags'
	, choices=['0', '1', '2', '3', 's']
	, help="LLVM optimization flag.")
parser.add_argument(
	  '--no-strip'
	, action='store_true'
	, dest='no_strip'
	, help="Do not invoke llvm-strip")
parser.add_argument(
	  '--print-cfr-time'
	, action='store_true'
	, dest='print_cfr_time'
	, help="Write CFR time to stats file.")
parser.add_argument(
	  '-c'
	, action='store_true'
	, dest='c'
	, help="Only run preprocess, compile, and assemble steps")
parser.add_argument(
	  '-o'
	, action='store'
	, default="a.out"
	, dest='ofile'
	, metavar='<file>'
	, help="Write output to file <file>")
parser.add_argument(
	  '-s'
	, action='store'
	, dest='sfile'
	, metavar='<file>'
	, help="Write stats to file <file>")
parser.add_argument(
	  '-###'
	, action='store_true'
	, dest='dry_run'
	, help="Print (but do not run) the commands for this compilation.")

class CLArgs(object):
	def __init__(self, cmds, dry_run):
		self.cmds = cmds
		self.dry_run = dry_run

def parse_args():
	args = parser.parse_args()

	pipeline = pipelines[args.pipeline]
	###
	# Remove llvm strip commands from pipeline
	###
	if args.no_strip:
		pipeline = [cmd for cmd in pipeline if not isinstance(cmd, llvm_strip)]

	objectfiles = []
	cmds = CommandList([])
	for f in args.files:
		ifile = f
		for cmd in copy.deepcopy(pipeline):
			###
			# Add include paths
			###
			if isinstance(cmd, clang) and args.includes:
				cmd.append_args(["-I"+include for include in args.includes])

			###
			# Add macros
			###
			if isinstance(cmd, clang) and args.macros:
				cmd.append_args(["-D"+macro for macro in args.macros])

			###
			# Set LLC optimization level
			###
			if isinstance(cmd, llc):
				cmd.append_args(["-O"+args.LLCOlvl[-1]])

			###
			# Set jlm-opt optimization flags
			###
			if isinstance(cmd, jlm_opt) and args.jlmoptflags:
				cmd.append_args(["-"+flag for flag in args.jlmoptflags])

			if isinstance(cmd, jlm_opt) and args.sfile:
				cmd.append_args(["-s", args.sfile])

			if isinstance(cmd, jlm_opt) and args.print_cfr_time:
				cmd.append_args(["--print-cfr-time"])


			###
			# Set llvm-opt optimization flags
			###
			if isinstance(cmd, llvm_opt) and args.llvmoptflags:
				cmd.append_args(["-O"+args.llvmoptflags])

			###
			# Set individual llvm-opt optimization flags
			###
			if isinstance(cmd, llvm_opt) and args.indvllvmoptflags:
				cmd.append_args([flag for flag in args.indvllvmoptflags])

			###
			# Set input files
			###
			cmd.set_ifile(ifile)
			ifile = cmd.ofile()

			if isinstance(cmd, llc):
				objectfiles.append(cmd.ofile())

			cmds += cmd

	if not args.c:
		lnkargs = [] if not args.libs else ["-l"+lib for lib in args.libs]
		cmds += lnk(lnkargs, objectfiles, args.ofile)

	return CLArgs(cmds, args.dry_run)

def in_path(cmd):
	def is_executable(fpath):
		return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

	for path in os.environ["PATH"].split(os.pathsep):
		if is_executable(os.path.join(path, cmd.cmd())):
			return True

	return False

def main():
	args = parse_args()
	for cmd in args.cmds:
		if not in_path(cmd):
			raise Exception("Could not find " + cmd.cmd() + " in $PATH.")

	if args.dry_run:
		print args.cmds
	else:
		args.cmds.run()

if __name__ == "__main__":
	main()
