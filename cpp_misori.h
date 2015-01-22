#ifndef MISORI_H
#define MISORI_H

#include <Eigen/Geometry>

typedef Eigen::Quaternion<float> Quat;
typedef Eigen::Map< Quat > QuatMap;
typedef Eigen::Map< const Quat > QuatMapConst;
typedef Eigen::AngleAxis<float> AxAng;

float cpp_misori(float* qa_buf, float* qb_buf, float* symm_buf, int n_symm);

#endif
