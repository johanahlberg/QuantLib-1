
/* 
Copyright (C) 2000 F.Ametrano, L.Ballabio, A.Benin, M.Marchioro
See the file LICENSE.TXT for information on usage and distribution
Contact ferdinando@ametrano.net if LICENSE.TXT was not distributed with this file
*/

#ifndef quantlib_vectors_i
#define quantlib_vectors_i

%module Vectors

#if !defined(SWIGPYTHON)
#if !defined(PYTHON_WARNING_ISSUED)
#define PYTHON_WARNING_ISSUED
%echo "Warning: this is a Python module!!"
%echo "Exporting it to any other language is not advised as it could lead to unpredicted results."
#endif
#endif

%{
// std::vector specializations
#include <vector>
typedef std::vector<int> IntVector;
typedef std::vector<double> DoubleVector;

// array
#include "array.h"
using QuantLib::Array;
%}

%typemap(python,in) IntVector, IntVector * {
	if (PyTuple_Check($source)) {
		int size = PyTuple_Size($source);
		$target = new IntVector(size);
		for (int i=0; i<size; i++) {
			PyObject* o = PyTuple_GetItem($source,i);
			if (PyInt_Check(o)) {
				(*$target)[i] = int(PyInt_AsLong(o));
			} else {
				PyErr_SetString(PyExc_TypeError,"tuple must contain integers");
				delete $target;
				return NULL;
			}
		}
	} else if (PyList_Check($source)) {
		int size = PyList_Size($source);
		$target = new IntVector(size);
		for (int i=0; i<size; i++) {
			PyObject* o = PyList_GetItem($source,i);
			if (PyInt_Check(o)) {
				(*$target)[i] = int(PyInt_AsLong(o));
			} else {
				PyErr_SetString(PyExc_TypeError,"list must contain integers");
				delete $target;
				return NULL;
			}
		}
	} else {
		PyErr_SetString(PyExc_TypeError,"not a sequence");
		return NULL;
	}
};

%typemap(python,freearg) IntVector, IntVector * {
	delete $source;
};

%typemap(python,out) IntVector, IntVector * {
	$target = PyTuple_New($source->size());
	for (int i=0; i<$source->size(); i++)
		PyTuple_SetItem($target,i,PyInt_FromLong((*$source)[i]));
};

%typemap(python,ret) IntVector {
	delete $source;
}


%typemap(python,in) DoubleVector, DoubleVector *, Array, Array * {
	if (PyTuple_Check($source)) {
		int size = PyTuple_Size($source);
		$target = new $basetype(size);
		for (int i=0; i<size; i++) {
			PyObject* o = PyTuple_GetItem($source,i);
			if (PyFloat_Check(o)) {
				(*$target)[i] = PyFloat_AsDouble(o);
			} else if (PyInt_Check(o)) {
				(*$target)[i] = double(PyInt_AsLong(o));
			} else {
				PyErr_SetString(PyExc_TypeError,"tuple must contain doubles");
				delete $target;
				return NULL;
			}
		}
	} else if (PyList_Check($source)) {
		int size = PyList_Size($source);
		$target = new $basetype(size);
		for (int i=0; i<size; i++) {
			PyObject* o = PyList_GetItem($source,i);
			if (PyFloat_Check(o)) {
				(*$target)[i] = PyFloat_AsDouble(o);
			} else if (PyInt_Check(o)) {
				(*$target)[i] = double(PyInt_AsLong(o));
			} else {
				PyErr_SetString(PyExc_TypeError,"list must contain doubles");
				delete $target;
				return NULL;
			}
		}
	} else {
		PyErr_SetString(PyExc_TypeError,"not a sequence");
		return NULL;
	}
};

%typemap(python,freearg) DoubleVector, DoubleVector *, Array, Array * {
	delete $source;
};

%typemap(python,out) DoubleVector, DoubleVector *, Array, Array * {
	$target = PyTuple_New($source->size());
	for (int i=0; i<$source->size(); i++)
		PyTuple_SetItem($target,i,PyFloat_FromDouble((*$source)[i]));
};

%typemap(python,ret) DoubleVector, Array {
	delete $source;
}


#endif
