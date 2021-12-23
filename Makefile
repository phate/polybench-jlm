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

# LLVM related variables
LLVMCONFIG ?= llvm-config
CLANG_BIN=$(shell $(LLVMCONFIG) --bindir)
CLANG=$(CLANG_BIN)/clang
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

