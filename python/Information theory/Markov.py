import numpy as np

p = np.array([0.75, 0.25, 0.25, 0.75]).reshape(2,2)
v = [[0,0] for i in range(1000)]
a = np.array([0.5, 0.5]).reshape(1,2)

for i in range(0, 1000):
    a = a.dot(p)
    v[i][0] = a[0][0]
    v[i][1] = a[0][1]

print(v)
