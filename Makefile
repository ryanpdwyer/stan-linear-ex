##
# Users should only need to set these three variables for use.
# - CC: The compiler to use. Expecting g++ or clang++.
# - O: Optimization level. Valid values are {0, 1, 2, 3}.
# - AR: archiver (must specify for cross-compiling)
# - OS: {mac, win, linux}. 



##
CC = g++
O = 3
O_STANC = 0
AR = ar
EXE=.exe

# See http://stackoverflow.com/a/18137056
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURR_DIR := $(patsubst %/,%,$(dir $(MKFILE_PATH)))

# All library paths should be correctly set after this.

STAN_ROOT ?= /c/cmdstan/

-include $(STAN_ROOT)make/detect_os

STAN_FILES=$(wildcard *.stan)

EXE_FILES=$(patsubst %.stan,%$(EXE),$(STAN_FILES))


help:
	@echo "all:           Make all stan models in the current directory"
	@echo "$(EXE):       Generate stan executable from model"

all: $(EXE_FILES) $(STAN_FILES)

%.hpp: %.stan
	$(MAKE) -C $(STAN_ROOT) $(CURR_DIR)/$@

%$(EXE): %.hpp
	$(MAKE) -C $(STAN_ROOT) $(CURR_DIR)/$@

# %.out: %.hpp
# 	$(MAKE) -C $(STAN_ROOT) $(CURR_DIR)/$@

