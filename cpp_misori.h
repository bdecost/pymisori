#ifndef MISORI_H
#define MISORI_H

#include <Eigen/Geometry>

typedef Eigen::Quaternion<double> Quat;
typedef Eigen::Map< Quat > QuatMap;
typedef Eigen::Map< const Quat > QuatMapConst;
typedef Eigen::AngleAxis<double> AxAng;

// double misori(double* qa_buf, double* qb_buf, double* symm_buf, int n_symm);
double misori(double* qa_buf, double* qb_buf);

#endif
