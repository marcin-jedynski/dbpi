#!/usr/bin/env python

# This script will generate all of the primitive roots
# for a given prime number.

def getPrimitiveRoot( prime ):
    num_to_check = 0
    p_minus_1_range = range(1,prime)
    print("If you entered a large number (4+ digits) this could take a long time.")
    print("")
    print("Working...")
    primitive_roots = []
    for each in range(1, prime):
    	num_to_check += 1
    	candidate_prim_roots = []
    	for i in range(1, prime):
    		modulus = (num_to_check ** i) % prime
    		candidate_prim_roots.append(modulus)
    		cleanedup_candidate_prim_roots = set(candidate_prim_roots)
    		if len(cleanedup_candidate_prim_roots) == len(range(1,prime)):
    			primitive_roots.append(num_to_check)
    print("Primitive roots of %d are:" % prime)
    print("-----------------------------------")
    print(primitive_roots)
    return(primitive_roots[0])
def gcd(a,b):
    while a != b:
        if a > b:
            a = a - b
        else:
            b = b - a
    return a

def primitive_root(modulo):
    required_set = set(num for num in range (1, modulo) if gcd(num, modulo) == 1)
    for g in range(1, modulo):
        actual_set = set(pow(g, powers) % modulo for powers in range (1, modulo))
        if required_set == actual_set:
            return g

prime = int(input("Enter a prime number: "))
#etPrimitiveRoot(prime)
print(primitive_root(prime))
