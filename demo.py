#!/usr/bin/env python
import numpy as np
import misori as m

# quaternion: np.array([x, y, z, w])
a = np.array([0.5,0.5,0.5,0.5],dtype=np.float32)
b = np.array([-0.5,0.5,0.5,0.5],dtype=np.float32)

v = m.misori(a,b)
print('{0} degrees'.format(v * 180/np.pi))
