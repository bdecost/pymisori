import numpy as np
cimport numpy as np

include "symmetry.pxi"

cdef extern from "cpp_misori.h":
  float cpp_misori(float* qa_buf, float* qb_buf,float* symm_buf, int n_symm);
	         
def misori(np.ndarray[np.float32_t, ndim=1] qa,
           np.ndarray[np.float32_t, ndim=1] qb,
	   np.ndarray[np.float32_t,ndim=2] symm=cubic_symmetry):
  """Compute misorientation angle in radians between two unit quaternions
  
  Required arguments:
  qa: unit quaternion numpy array: [x, y, z, w]
  qb: unit quaternion numpy array: [x, y, z, w]

  Keyword argument:
  symm: 2D numpy array containing unit quaternion symmetry operators.
        defaults to cubic symmetry (as defined in 'symmetry.pxi')
  """
  cdef np.ndarray[float,mode="c"] qa_buf = np.ascontiguousarray(qa.astype('float32'))
  cdef np.ndarray[float,mode="c"] qb_buf = np.ascontiguousarray(qb.astype('float32'))
  cdef np.ndarray[float,mode="c"] symm_buf = np.ascontiguousarray(symm.flatten().astype('float32'))
  cdef m = cpp_misori(&qa_buf[0], &qb_buf[0], &symm_buf[0], symm.shape[0])
  return m

