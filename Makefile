define HELP_TEXT
clear
echo "Makefile for the polybench suite"
echo "Version 1.0 - 2019-06-18"
endef
.PHONY: help
help:
	@$(HELP_TEXT)
	@$(HELP_TEXT_POLYBENCH)
	@echo "all                    Compiles all targets for all benchmarks"
	@echo "compare                Alias for polybench-compare"
	@echo "check                  Alias for polybench-check"
	@echo "time                   Alias for polybench-time"
	@echo "size                   Alias for polybench-size"
	@echo "clean                  Alias for polybench-clean"
	@echo "purge                  Alias for polybench-purge"

POLYBENCH_ROOT ?= .

JLC?=jlc
CGEIST?=cgeist

# LLVM related variables
LLVM_VERSION = 18
LLVMCONFIG ?= llvm-config-$(LLVM_VERSION)
LLVM_BIN_DIR=$(shell $(LLVMCONFIG) --bindir)
LLVM_INCLUDE_DIR=$(shell $(LLVMCONFIG) --includedir)
LLVM_LIB_DIR=$(shell $(LLVMCONFIG) --libdir)
CLANG=$(LLVM_BIN_DIR)/clang
LLC=$(LLVM_BIN_DIR)/llc
CC=$(CLANG)

include $(POLYBENCH_ROOT)/Makefile.sub

.PHONY: all
all: polybench

.PHONY: clean
clean: polybench-clean

.PHONY: purge
purge: polybench-purge

.PHONY: compare
compare: polybench-compare

.PHONY: check
check: polybench-check

.PHONY: time
time: polybench-time

.PHONY: size
size: polybench-size

