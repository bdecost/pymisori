import numpy as np
cimport numpy as np

cdef extern from "cpp_misori.h":
  double misori(double* qa_buf, double* qb_buf);

cdef double callmisori(qa, qb):
  cdef np.ndarray[double,mode="c"] qa_buf = np.ascontiguousarray(qa.astype('float'))
  cdef np.ndarray[double,mode="c"] qb_buf = np.ascontiguousarray(qb.astype('float'))
  cdef m = misori(&qa_buf[0], &qb_buf[0])
  return m
  
def mis(qa, qb):
  return callmisori(qa, qb)