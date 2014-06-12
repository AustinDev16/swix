//
//  oneD_arth.swift
//  swix
//
//  Created by Scott Sievert on 6/11/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
// ARTITHEMETIC OPERATORS
// +
operator infix + {associativity none precedence 140}
func + (left: matrix, right: matrix) -> matrix{
    if left.count != right.count{
        println("`+` only works with arrays of equal size!")
    }
    assert(left.count == right.count)
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] + right[i]
    }
    return x
    
}
func + (left: Double, right: matrix) -> matrix{
    var N = right.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left + right[i]
    }
    //    var input = left.bridgeToObjectiveC().doubleValue
    //    var inreal: CMutablePointer<Double> = &input
    //    println(inreal)
    //    vDSP_vsaddD(right, 1, input, inreal.value, 1, N)
    return x
}

func + (left: matrix, right: Double) -> matrix{
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] + right
    }
    return x
}
// -
operator infix - {associativity none precedence 140}
func - (left: matrix, right: matrix) -> matrix{
    if left.count != right.count{
        println("`+` only works with arrays of equal size.")
    }
    assert(left.count == right.count)
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] - right[i]
    }
    return x
}
func - (left: Double, right: matrix) -> matrix{
    var N = right.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left - right[i]
    }
    return x
}
func - (left: matrix, right: Double) -> matrix{
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] - right
    }
    return x
}


// *
operator infix * {associativity none precedence 140}
func * (left: matrix, right: matrix) -> matrix{
    if left.count != right.count{
        println("`*` only works with arrays of equal size. It does element wise multiplication, not dot product (like NumPy)")
    }
    assert(left.count == right.count)
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] * right[i]
    }
    return x
}
func * (left: Double, right: matrix) -> matrix{
    var N = right.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left * right[i]
    }
    return x
}
func * (left: matrix, right: Double) -> matrix{
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] * right
    }
    return x
}
// /
operator infix / {associativity none precedence 140}
func / (left: matrix, right: matrix) -> matrix{
    if left.count != right.count{
        println("`/` only works with arrays of equal size. It does element wise multiplication")
    }
    assert(left.count == right.count)
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] / right[i]
    }
    return x
}
func / (left: Double, right: matrix) -> matrix{
    var N = right.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left / right[i]
    }
    return x
}
func / (left: matrix, right: Double) -> matrix{
    var N = left.count
    var x = zeros(N)
    for i in 0..N{
        x[i] = left[i] / right
    }
    return x
}