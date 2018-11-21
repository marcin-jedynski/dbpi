from Cryptodome.Util import number
from random import *
import random

def primitive_root():
    while (True):
        q  = number.getPrime(64)
        p = 2 * q + 1
        if(number.isPrime(p)):
            break
        else:
            continue
    while(True):
        g = randint(2,p-1)
        if(pow(g,2,p) != 1 and pow(g,q,p) != 1):
            return [p,g]

p,g = primitive_root()
print('Prime number chosen P = %d\n Generator for P is G = %d\n' % (p,g))

alice_private = randint(200, 100000)
print('Alice private key is %d' % alice_private)
bob_private = randint(200, 100000)
print('Bob private key is %d' % bob_private)


alice_public = pow(g, alice_private) % p
print('Alice public key is %d' % alice_public)
bob_public = pow(g, bob_private) % p
print('Bob public key is %d' % bob_public)

alice_key = (pow(bob_public, alice_private)) % p
bob_key = (pow(alice_public, bob_private)) % p

print('\n Common secret: %d == %d' % (alice_key, bob_key))
print(alice_key.bit_length())
print(alice_private.bit_length())
print(alice_public.bit_length())





