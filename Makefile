define HELP_TEXT
clear
echo "Makefile for the polybench suite"
echo "Version 1.0 - 2019-06-18"
endef
.PHONY: help
help:
	@$(HELP_TEXT)
	@$(HELP_TEXT_POLYBENCH)
	@echo "submodule              Initializes all the dependent git submodules"
	@echo "all                    Compiles jlm, and runs unit and C tests"
	@echo "clean                  Alias for polybench-clean"
	@echo "purge                  Calls polybench-purge and clean for llvm-strip"
	@$(HELP_TEXT_LLVMSTRIP)

POLYBENCH_ROOT ?= .
LLVMSTRIP_ROOT = $(POLYBENCH_ROOT)/external/llvm-strip

include $(POLYBENCH_ROOT)/Makefile.sub
ifneq ("$(wildcard $(LLVMSTRIP_ROOT)/Makefile.sub)","")
include $(LLVMSTRIP_ROOT)/Makefile.sub
endif

.PHONY: all
all: polybench

.PHONY: submodule
submodule:
	git submodule update --init --recursive

.PHONY: clean
clean: polybench-clean

.PHONY: purge
purge: polybench-purge llvm-strip-clean

.PHONY: compare
compare: polybench-compare

.PHONY: time
time: polybench-time

.PHONY: size
size: polybench-size

