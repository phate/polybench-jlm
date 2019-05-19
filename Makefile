POLYBENCH_ROOT ?= .

include $(POLYBENCH_ROOT)/Makefile.sub

all:	$(POLYBENCH_ROOT)/config.mk \
	\
	OPTO0-LLCO0 \
	OPTO0-LLCO1 \
	OPTO0-LLCO3 \
	OPTO0-LLCO0-stripped \
	OPTO0-LLCO3-stripped \
	\
	OPTO1-LLCO0 \
	OPTO1-LLCO1 \
	OPTO1-LLCO3 \
	OPTO1-LLCO0-stripped \
	OPTO1-LLCO3-stripped \
	\
	OPTO2-LLCO0 \
	OPTO2-LLCO1 \
	OPTO2-LLCO3 \
	OPTO2-LLCO0-stripped \
	OPTO2-LLCO3-stripped \
	\
	OPTO3-LLCO0 \
	OPTO3-LLCO1 \
	OPTO3-LLCO3 \
	OPTO3-LLCO0-stripped \
	OPTO3-LLCO3-stripped \
	\
	OPTO3-no-vec-LLCO0 \
	OPTO3-no-vec-LLCO3 \
	OPTO3-no-vec-LLCO0-stripped \
	OPTO3-no-vec-LLCO3-stripped \
	\
	OPTOs-LLCO0 \
	OPTOs-LLCO1 \
	OPTOs-LLCO3 \
	OPTOs-LLCO0-stripped \
	OPTOs-LLCO3-stripped \
	\
	jlm-LLCO0 \
	jlm-LLCO1 \
	jlm-LLCO3 \
	\
	jlm-no-unroll-LLCO3 \
	jlm-no-opt-LLCO3 \
	clang \
	gcc \


.PHONY: llvm-strip
llvm-strip: $(POLYBENCH_ROOT)/external/llvm-strip/llvm-strip

.PHONY: clean
clean: polybench-clean

.PHONY: clean-all
clean-all: polybench-clean-all

.PHONY: compare
compare: polybench-compare

.PHONY: time
time: polybench-time
