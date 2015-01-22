#!/usr/bin/env python
import numpy as np
import h5py
import matplotlib.pyplot as plt
import os

import misori as m

# check misorientation code by comparing to DREAM3D-produced misorientations
dataset_path = os.path.join('data', 'CubicSingleEquiaxedOut.dream3d')
f = h5py.File(dataset_path)

# just presume a DREAM3Dv6 file format with default synthetic dataset name
data = f['DataContainers/SyntheticVolume/CellFeatureData']
MisorientationList = data['MisorientationList']
NumNeighbors = data['NumNeighbors']
NeighborList = data['NeighborList']
AvgQuats = np.array(data['AvgQuats'],dtype=np.float32)

# NeighborList is a linked list stored in a flat array
# use NumNeighbors to traverse the list and build a MisorientationList
ctr = 0;
misorientations = np.zeros(len(MisorientationList),dtype=np.float32)
for i,nneigh in enumerate(NumNeighbors):
  qa = AvgQuats[i]
  n = nneigh[0]
  for j in range(n):
    index = ctr + j
    qb = AvgQuats[NeighborList[index]]
    misorientations[index] = m.misori(qa,qb)
  ctr += n

misorientations = misorientations * (180/np.pi)
s_error = np.square(np.array(MisorientationList) - misorientations)
max_error = np.max(np.sqrt(s_error))
RMS_error = np.sqrt(np.mean(s_error))
print('Max error: {0} degrees'.format(max_error))
print('RMS error: {0} degrees'.format(RMS_error))

plt.hist(misorientations, 25, normed=True, histtype='step',label='calculated')
plt.hist(np.array(MisorientationList), 25, normed=True, histtype='step',label='DREAM3D')
plt.legend(loc='best')
plt.xlabel('Misorientation angle (degrees)')
plt.ylabel('Probability density')
plt.title('Approximate MDF')
plt.show()
