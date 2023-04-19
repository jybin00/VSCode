import numpy as np

source_b = np.random.binomial(1, 1/2, size=1)  # Markov chain으로
print(source_b, type(source_b)) 
print(source_b[0])

print("hi")
a = 10

b = 20

def mul(a,b):
    c = a*b
    return c

print(mul(1,2))
source_b = source_b.tolist()

for i in range(1,10):
    #print(source_b[i-1])
    source_b.append(1)
print(source_b)

source_b = np.random.binomial(1, 3/4, size=1)
print(source_b)
source_b = np.random.binomial(0, 3/4, size=1)
print(source_b)
print(1^0)