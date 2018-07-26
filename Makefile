
# -Wconversion

SUFFIX = _tr29124
CXX_INST_DIR = $(HOME)/bin$(SUFFIX)
ifeq ("$(wildcard $(CXX_INST_DIR))","")
  SUFFIX = 
  CXX_INST_DIR = $(HOME)/bin
  ifeq ("$(wildcard $(CXX_INST_DIR))","")
    ifneq ($(wildcard "/mingw64"),"")
      CXX_INST_DIR = /mingw64
    else
      CXX_INST_DIR = /usr
    endif
  endif
endif

GFORTRAN = $(CXX_INST_DIR)/bin/gfortran -g -Wall -Wextra -Wno-compare-reals
GCC = $(CXX_INST_DIR)/bin/gcc -g -Wall -Wextra
CXX = $(CXX_INST_DIR)/bin/g++ -std=gnu++14 -g -D__STDCPP_WANT_MATH_SPEC_FUNCS__ -Wall -Wextra -Wno-psabi
CXX17 = $(CXX_INST_DIR)/bin/g++ -std=gnu++17 -fconcepts -g -Wall -Wextra -Wno-psabi
CXX_INC_DIR = $(CXX_INST_DIR)/include/c++/7.0.0/bits
CXX_LIB_DIR = $(CXX_INST_DIR)/lib64
CXX_TEST_INC_DIR = .

BINS = \
       test_bairstow \
       test_horner \
       test_jenkins_traub \
       test_polynomial \
       test_polynomial_root \
       test_rational_polynomial \
       test_solvers \
       test_static_polynomial

all: $(BINS)

polynomial.h: polynomial.tcc

solver_low_degree.h: solution.h solver_low_degree.tcc

rational_polynomial.h: polynomial.h

test_bairstow: test_bairstow.cpp
	$(CXX17) -I. -I.. -o test_bairstow test_bairstow.cpp -lquadmath

test_horner: test_horner.cpp
	$(CXX17) -I. -I.. -o test_horner test_horner.cpp -lquadmath

test_jenkins_traub: solution.h solver_low_degree.h polynomial.h test_jenkins_traub.cpp
	$(CXX17) -I. -I.. -o test_jenkins_traub test_jenkins_traub.cpp -lquadmath

test_polynomial: polynomial.h polynomial.tcc test_polynomial.cpp
	$(CXX17) -I. -I.. -o test_polynomial test_polynomial.cpp -lquadmath

test_polynomial_root: polynomial.h test_polynomial_root.cpp
	$(CXX17) -I. -I.. -o test_polynomial_root test_polynomial_root.cpp -lquadmath

test_rational_polynomial: rational_polynomial.h test_rational_polynomial.cpp
	$(CXX17) -I. -I.. -o test_rational_polynomial test_rational_polynomial.cpp -lquadmath

test_solvers: solution.h solver_low_degree.h solver_low_degree.tcc test_solvers.cpp
	$(CXX17) -I. -I.. -o test_solvers test_solvers.cpp -lquadmath

test_static_polynomial: static_polynomial.h test_static_polynomial.cpp
	$(CXX17) -I. -I.. -o test_static_polynomial test_static_polynomial.cpp -lquadmath

docs: *.h *.tcc *.cpp
	rm -rf html/*
	rm -rf latex/*
	doxygen
	cd latex && make

test:
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_rational_polynomial > test_rational_polynomial.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_bairstow.in > test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver1.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver2.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver3.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver4.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver5.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver6.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver7.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_bairstow < test_solver8.in >> test_bairstow.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_horner > test_horner.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver1.in > test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver2.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver3.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver4.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver5.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver6.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver7.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_jenkins_traub < test_solver8.in >> test_jenkins_traub.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_polynomial > test_polynomial.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_polynomial_root > test_polynomial_root.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_solvers > test_solvers.txt
	LD_LIBRARY_PATH=$(CXX_LIB_DIR):$$LD_LIBRARY_PATH ./test_static_polynomial > test_static_polynomial.txt

clean:
	rm -f $(BINS) a.out
	rm -f *.stackdump
