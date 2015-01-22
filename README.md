pymisori
--------

A small utility I cooked up to compute crystallographic misorientations in python. I mostly wrote this to 1. learn about cython and 2. I need to calculate some crystallographic misorientations for an analysis I'm working on, which is implemented in python.

I didn't want to write a quaternion class in python, so I implemented the misorientation calculation in C++ using `Eigen`, and wrapped that with cython. It's easy to pull the quaternions from a `DREAM3D` format file into a numpy array and feed them to `pymisori`.

To compile `pymisori`, run `python setup.py build_ext -i` from the shell. You need to have [Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page) installed, and you may need to specify the include directory in `setup.py` so that cython can find the `Eigen` library files. Once it's compiled, you should be able to simply `import misori` in the python interpreter (you need to set up your `$PYTHONPATH` if you want to use this outside of the `pymisori` source root).

There's a barebones `demo.py` that shows how to make a numpy array representing a quaternion ([x, y, z, w] convention). This should be a unit quaternion, or Bad Things<sup>TM</sup> will happen.
Also, take a look at `test_misori.py` -- it demonstrates `pymisori` in action, and it also demonstrates how one can extract some data from a `DREAM3D` file using `h5py`.
