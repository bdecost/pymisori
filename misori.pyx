import numpy as np
cimport numpy as np

cdef extern from "cpp_misori.h":
  float cpp_misori(float* qa_buf, float* qb_buf,float* symm_buf, int n_symm);

def misori(np.ndarray[np.float32_t, ndim=1] qa, np.ndarray[np.float32_t,ndim=1] qb, np.ndarray[np.float32_t,ndim=2] symm):
  cdef np.ndarray[float,mode="c"] qa_buf = np.ascontiguousarray(qa.astype('float32'))
  cdef np.ndarray[float,mode="c"] qb_buf = np.ascontiguousarray(qb.astype('float32'))
  cdef np.ndarray[float,mode="c"] symm_buf = np.ascontiguousarray(symm.flatten().astype('float32'))
  cdef m = cpp_misori(&qa_buf[0], &qb_buf[0], &symm_buf[0], symm.shape[0])
  return m

def misori(np.ndarray[np.float32_t, ndim=1] qa, np.ndarray[np.float32_t,ndim=1] qb):
  cdef np.ndarray[float,mode="c"] qa_buf = np.ascontiguousarray(qa)
  cdef np.ndarray[float,mode="c"] qb_buf = np.ascontiguousarray(qb)
  symm = cubic_symmetry
  cdef np.ndarray[float,mode="c"] symm_buf = np.ascontiguousarray(symm.flatten().astype('float32'))
  cdef m = cpp_misori(&qa_buf[0], &qb_buf[0], &symm_buf[0], symm.shape[0])
  return m

invsqrt2 = 1.0 / np.sqrt(2.0)
cubic_symmetry = np.array([[0,0,0,1],
	       [1,0,0,0],
	       [0,1,0,0],
	       [0,0,1,0],
	       
	       [invsqrt2, 0, 0, invsqrt2],
	       [0, invsqrt2, 0, invsqrt2],
	       [0, 0, invsqrt2, invsqrt2],
	       [-invsqrt2, 0, 0, invsqrt2],
	       
	       [0, -invsqrt2, 0, invsqrt2],
	       [0, 0, -invsqrt2, invsqrt2],
	       [invsqrt2, invsqrt2, 0, 0],
	       [-invsqrt2, invsqrt2, 0, 0],
	       
	       [0, invsqrt2, invsqrt2, 0],
	       [0, -invsqrt2, invsqrt2, 0],
	       [invsqrt2, 0, invsqrt2, 0],
	       [-invsqrt2, 0, invsqrt2, 0],
	       
	       [0.5, 0.5, 0.5, 0.5],
	       [-0.5, -0.5, -0.5, 0.5],
	       [0.5, -0.5, 0.5, 0.5],
	       [-0.5, 0.5, -0.5, 0.5],
	       
	       [-0.5, 0.5, 0.5, 0.5],
	       [0.5, -0.5, -0.5, 0.5],
	       [-0.5, -0.5, 0.5, 0.5],
	       [0.5, 0.5, -0.5, -0.5]], dtype=np.float32)
	       
