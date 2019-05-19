define HELP_TEXT
clear
echo "Makefile for the polybench suite"
echo "Version 1.0 - 2019-06-18"
endef
.PHONY: help
help:
	@$(HELP_TEXT)
	@$(HELP_TEXT_POLYBENCH)
	@$(HELP_TEXT_LLVMSTRIP)

POLYBENCH_ROOT ?= .
LLVMSTRIP_ROOT = $(POLYBENCH_ROOT)/external/llvm-strip

LLVMCONFIG ?= llvm-config

include $(POLYBENCH_ROOT)/Makefile.sub
include $(LLVMSTRIP_ROOT)/Makefile.sub

.PHONY: all
all: polybench

.PHONY: clean
clean: polybench-clean

.PHONY: clean-all
clean-all: polybench-clean-all llvm-strip-clean

.PHONY: compare
compare: polybench-compare

.PHONY: time
time: polybench-time

.PHONY: size
size: polybench-size

