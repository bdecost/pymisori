pymisori
--------

A small utility I cooked up to compute crystallographic misorientations in python.

I didn't want to write a quaternion class in python, so I implemented the misorientation calculation in C++ using `Eigen`, and wrapped that with cython.

