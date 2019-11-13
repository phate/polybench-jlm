define HELP_TEXT
clear
echo "Makefile to create llvm and xml from the polybench benchmakrs"
echo "Needs to have the jlm compiler in the path"
echo "Version 1.0 - 2019-11-14"
endef

.PHONY: default
default: all;

.PHONY: help
help:
	@$(HELP_TEXT)

CC             = clang
INCLUDE        = -I$(POLYBENCH_ROOT)/utilities
LLVM           = -S -emit-llvm -Xclang -disable-llvm-passes

POLYBENCH_ROOT = ..
OUTPUT_LLVM    = llvm
OUTPUT_XML     = xml

include Makefile.benchmarks

.PHONY: all
all: CPPFLAGS += ${INCLUDE} ${LLVM}
all: $(patsubst %, %/clang, $(POLY_BENCHMARKS))

.PHONY: clean
clean:
	@rm -f $(OUTPUT_LLVM)/* $(OUTPUT_XML)/*
