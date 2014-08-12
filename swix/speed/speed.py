from __future__ import division
from pylab import *
from timeit import timeit

def pe1():
    N = 1e6
    x = arange(N)
    i = argwhere((abs(x%3) < 1e-9) * (abs(x%5) < 1e-9))
def pe10():
    N = 2e6
    primes = arange(N)
    for i in arange(2, sqrt(N)):
        j = arange(2, N/i) * i
        j = asarray(j, dtype=int)
        primes[j] *= 0.0
def soft_threshold():
    N = 1e2
    j = linspace(-1, 1, num=N)
    (x, y) = meshgrid(j, j)
    z = pow(x, 2) + pow(y, 2)
    i = abs(z) < 0.5
    z[argwhere(i)] *= 0
    z[argwhere(~i)] -= 0.5
def pi_approx():
    N = 1e6
    k = arange(N, dtype=int)
    pi_approx = 1 / (2*k + 1)
    pi_approx[2*k[:N/2]+1] *= -1

# PROJECT EULER 3
def is_prime(n):
    i = argwhere(abs(primes - n) < 1e-9)
    return False if i.shape[0] == 0 else True
def sieve():
    primes = arange(n)
    for i in arange(2, sqrt(n)):
        idx = arange(2, n/i, dtype=int) * i
        idx = asarray(idx, dtype=int)
        primes[idx] = 0
    primes = delete(primes, argwhere(abs(primes) < 1e-9))
    return primes
def prime_factors(n):
    if is_prime(n): return array([n])
    else:
        div = -1
        for i in arange(2, sqrt(n)):
            if n/i % 1.0 == 0:
                div = i
                break
        t = array([div])
        p = prime_factors(n/div)
        return hstack((t, p))

n = 100
primes = sieve()
print prime_factors(13195)

#pe1_time = timeit(pe1, number=3)
#print "pe1_time:", pe1_time
#pe10_time = timeit(pe10, number=3)
#print "pe10_time:", pe10_time
#st_time = timeit(soft_threshold, number=1)
#print "st_time:", st_time
#pi_time = timeit(pi_approx, number=1)
#print "pi_time:", pi_time
