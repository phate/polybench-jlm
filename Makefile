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
	@echo "purge                  Calls polybench-purge"

POLYBENCH_ROOT ?= .

include $(POLYBENCH_ROOT)/Makefile.sub

.PHONY: all
all: polybench

.PHONY: submodule
submodule:
	git submodule update --init --recursive

.PHONY: clean
clean: polybench-clean

.PHONY: purge
purge: polybench-purge

.PHONY: compare
compare: polybench-compare

.PHONY: time
time: polybench-time

.PHONY: size
size: polybench-size

