#include "cpp_misori.h"
#include <cmath>
#include <iostream>

/* Compute misorientation angle between two quaternions in radians */
/* Using Eigen to do the quaternion math */
/* No guarantee that the axis is in the fundamental zone... */
float cpp_misori(float* qa_buf, float* qb_buf, float* symm_buf, int n_symm) {

  float min_angle = 999999;
  float angle = 0;
  Quat misori, q_outer, q_inner, min_misori;

  /* memory-map raw buffers to Eigen::Quaternion */
  /* Assume qa_buf and qb_buf point to __unit quaternions__ */
  QuatMapConst qa(qa_buf);
  QuatMapConst qb(qb_buf);

  /* Following DREAM3D conventions: quaternions as passive rotations */
  misori = qa.inverse() * qb;
  misori.normalize();

  /* Apply crystal symmetry for orientation a */
  for (int ii = 0; ii < n_symm; ii++) {
    QuatMapConst symm_i(&symm_buf[4*ii]);
    q_outer = misori * symm_i;
    q_outer.normalize();
    
    /* Apply crystal symmetry for orientation b */
    for (int jj = 0; jj < n_symm; jj++) {
      QuatMapConst symm_j(&symm_buf[4*jj]);
      q_inner = symm_j * q_outer;
      q_inner.normalize();

      /* Apply switching symmetry */
      for (int switch_symm = 0; switch_symm < 2; switch_symm++) {
	q_inner.w() = -q_inner.w();

	/* check the angle */
	angle = 2 * acos(q_inner.w());
	if (angle > M_PI)
	  angle = 2*M_PI - angle;
	if (angle < min_angle) {
	  min_misori = q_inner;
	  min_angle = angle;
	}
      }
    }
  }
  return std::max(min_angle, static_cast<float>(0.0));
}
