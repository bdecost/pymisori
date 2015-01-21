#include "cpp_misori.h"

double misori(double* qa_buf, double* qb_buf) {
  Quat q;
  AxAng a;

  QuatMapConst qa(qa_buf);
  QuatMapConst qb(qb_buf);

  q = qb * qa.inverse();
  a = AxAng(q);
  return a.angle();
}
