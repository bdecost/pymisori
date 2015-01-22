#include "cpp_misori.h"
#include <cmath>
#include <iostream>

float cpp_misori(float* qa_buf, float* qb_buf, float* symm_buf, int n_symm) {
  float wmin = 999999;
  float w = 0;
  Quat qmis, q_i, q_j, q;

  QuatMap qa(qa_buf);
  qa.normalize();
  QuatMap qb(qb_buf);
  qb.normalize();

  /* Following DREAM3D conventions: quaternions as passive rotations */
  qmis = qa.inverse() * qb;
  qmis.normalize();

  for (int ii = 0; ii < n_symm; ii++) {
    QuatMapConst symm_i(&symm_buf[4*ii]);
    q_i = symm_i * qmis;
    q_i.normalize();
    for (int jj = 0; jj < n_symm; jj++) {
      QuatMapConst symm_j(&symm_buf[4*jj]);
      q_j = q_i * symm_j;
      q_j.normalize();
      for (int switch_symm = 0; switch_symm < 2; switch_symm++) {
	w = 2 * acos(q_j.w());
	if (w > M_PI)
	  w = 2*M_PI - w;
	if (w < wmin) {
	  q = q_j;
	  wmin = w;
	}
	q_j.w() = -q_j.w();
      }
    }
  }
  return wmin;
}
