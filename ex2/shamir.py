from scipy import interpolate
from Crypto.Util import number
from random import seed
from random import random
from random import randint
import numpy as np
from numpy.polynomial.polynomial import *

# seed random number generator
seed(1)

n_length = 128
S = 666
n = 10
t=5

factors=[S]
shares = []

primeNum = number.getPrime(n_length)
for i in xrange(1,t-1):
    factors.append(randint(0,primeNum))

for i in xrange(1,n):
    shares.append(polyval(i,factors) % primeNum)

print (primeNum)
print(factors)
print(shares)


    