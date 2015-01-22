# specify symmetry operator as numpy array of unit quaternions:
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