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

# All library paths should be correctly set after this.

STAN_ROOT ?= /c/cmdstan/
STANV ?= 2.10.0

# STANC can also be set using $(STAN_ROOT)bin/stanc
STANC=stanc

STAN_FILES=$(wildcard *.stan)
MODEL_FILES=$(patsubst %.stan,%.model,$(STAN_FILES))

##
# Library locations
##
STAN ?= $(STAN_ROOT)stan/
STAN_SRC ?= $(STAN_ROOT)src/
MATH ?= $(STAN)lib/stan_math/
EIGEN ?= $(MATH)lib/eigen_3.2.8
BOOST ?= $(MATH)lib/boost_1.60.0
GTEST ?= $(MATH)lib/gtest_1.7.0
CPPLINT ?= $(MATH)lib/cpplint_4.45
CVODES ?= $(MATH)lib/cvodes_2.8.2
MAIN ?= $(STAN_SRC)cmdstan/main.cpp

##
# Set default compiler options.
## 
CFLAGS = -DBOOST_RESULT_OF_USE_TR1 -DBOOST_NO_DECLTYPE -DBOOST_DISABLE_ASSERTS -I $(STAN_SRC) -I $(STAN)src -isystem $(MATH) -isystem $(EIGEN) -isystem $(BOOST) -isystem $(CVODES) -Wall -pipe -DEIGEN_NO_DEBUG
CFLAGS_GTEST = -DGTEST_USE_OWN_TR1_TUPLE
LDLIBS =
LDLIBS_STANC = -Llib -lstanc
EXE = 
PATH_SEPARATOR = /
CMDSTAN_VERSION := 2.9.0

help:
	@echo "all:           Make all stan models in the current directory"
	@echo "%.model:       Generate stan executable from model"

all: $(MODEL_FILES) $(STAN_FILES)

%.hpp: %.stan
	$(STANC) $< --o=$@

%.model: %.hpp
	$(CC) $(CFLAGS) $(MAIN) -o $@ -include $<



