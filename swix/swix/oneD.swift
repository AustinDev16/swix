//
//  oneD.swift
//  swix
//
//  Created by Scott Sievert on 6/11/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation

// nice initins
func ones(length: Int) -> matrix {
    var x = Array(count: length, repeatedValue: 1.0)
    return x
}
func zeros(length: Int) -> matrix {
    var x = Array(count: length, repeatedValue: 0.0)
    return x
}
func array(numbers: Double...) -> matrix{
    var x = zeros(numbers.count)
    var i = 0
    for number in numbers{
        x[i] = number
        i++
    }
    return x
    
}
// EQUALITY OPERATORS
// ~== : almost equal
operator infix ~== {associativity none precedence 140}
func ~== (left: matrix, right: matrix) -> Bool{
    if left.count != right.count{
        println("`~=` only works with arrays of equal size!")
    }
    assert(left.count == right.count)
    var N = left.count
    var x = zeros(N)
    var not_false = 0
    for i in 0..N{
        if (left[i] - right[i]) > 1e-9{
            return false
        }
    }
    return true
}
// ==
operator infix == {associativity none precedence 140}
func == (left: matrix, right: matrix) -> Bool{
    if left.count != right.count{
        println("`==` only works with arrays of equal size!")
    }
    assert(left.count == right.count)
    var N = left.count
    var x = zeros(N)
    var not_false = 0
    for i in 0..N{
        if left[i] != right[i]{
            return false
        }
    }
    return true
}


