// -*- C++ -*-
// 
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  Lithomop3d by Charles A. Williams
//  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
//  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
//  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 
//
#include <portinfo>
#include <Python.h>

#include "array.h"


// allocateInt
char pylithomop3d_allocateInt__doc__[] = "";
char pylithomop3d_allocateInt__name__[] = "allocateInt";

PyObject * pylithomop3d_allocateInt(PyObject *, PyObject * args)
{

  int len;
  //  int i;

  int ok = PyArg_ParseTuple(args, "i:allocateInt",&len);
  
  if (!ok) {
    return 0;
  }
  
  int * p = (int *)malloc(sizeof(int)*len);

  // Experimental portion to initialize all values to zero.
  //  for (i = 0; i < len; ++i)
      //p[i] = 0;

  // Experimental section to increment the reference count for the
  // array pointer.
  PyObject *arrayPointer;
  arrayPointer = PyCObject_FromVoidPtr(p,clearp);
    //Py_XINCREF(arrayPointer);

  // return
  return arrayPointer;

}


// allocateDouble
char pylithomop3d_allocateDouble__doc__[] = "";
char pylithomop3d_allocateDouble__name__[] = "allocateDouble";

PyObject * pylithomop3d_allocateDouble(PyObject *, PyObject * args)
{

  int len;
  // int i;

  int ok = PyArg_ParseTuple(args, "i:allocateDouble",&len);
  
  if (!ok) {
    return 0;
  }
  
  double * p = (double *)malloc(sizeof(double)*len);

  // Experimental portion to initialize all values to zero.
    //for (i = 0; i < len; ++i)
      //p[i] = 0.0;

  // Experimental section to increment the reference count for the
  // array pointer.
  PyObject *arrayPointer;
  arrayPointer = PyCObject_FromVoidPtr(p,clearp);
    //Py_XINCREF(arrayPointer);

  // return
  return arrayPointer;

}


// intListToArray
char pylithomop3d_intListToArray__doc__[] = "";
char pylithomop3d_intListToArray__name__[] = "intListToArray";

PyObject * pylithomop3d_intListToArray(PyObject *, PyObject * args)
{
  PyObject *listobj;
  PyObject *listitem;
  int len,i;

  int ok = PyArg_ParseTuple(args, "O!:intListToArray",&PyList_Type,&listobj);

  if (!ok) {
    return 0;
  }

  len = PyList_Size(listobj);
  int * p = (int *)malloc(sizeof(int)*len);
  for(i=0;i<len;i++) {
    listitem = PyList_GetItem(listobj,i);
    if(!PyInt_Check(listitem)) {  //error if list item is not int
      return 0;			  //may want better error handling
    }
    p[i] = (int)PyInt_AsLong(listitem);
  }

  // Experimental section to increment the reference count for the
  // array pointer.
  PyObject *arrayPointer;
  arrayPointer = PyCObject_FromVoidPtr(p,clearp);
    //Py_XINCREF(arrayPointer);

  // return
  return arrayPointer;

}


// doubleListToArray
char pylithomop3d_doubleListToArray__doc__[] = "";
char pylithomop3d_doubleListToArray__name__[] = "doubleListToArray";

PyObject * pylithomop3d_doubleListToArray(PyObject *, PyObject * args)
{
  PyObject *listobj;
  PyObject *listitem;
  int len,i;

  int ok = PyArg_ParseTuple(args, "O!:doubleListToArray",&PyList_Type,&listobj);

  if (!ok) {
    return 0;
  }

  len = PyList_Size(listobj);
  double * p = (double *)malloc(sizeof(double)*len);
  for(i=0;i<len;i++) {
    listitem = PyList_GetItem(listobj,i);
    if(!PyFloat_Check(listitem)) {  //error if list item is not float
      return 0;			  //may want better error handling
    }
    p[i] = PyFloat_AsDouble(listitem);
  }

  // Experimental section to increment the reference count for the
  // array pointer.
  PyObject *arrayPointer;
  arrayPointer = PyCObject_FromVoidPtr(p,clearp);
    //Py_XINCREF(arrayPointer);

  // return
  return arrayPointer;

}


// clearp 
// deconstructor
void clearp(void *p)
{
  free(p);
  p = NULL;
  return;
}


// version
// $Id: array.cc,v 1.3 2005/03/31 23:27:57 willic3 Exp $

// End of file
