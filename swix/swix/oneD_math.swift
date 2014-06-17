//
//  oneD_math.swift
//  swix
//
//  Created by Scott Sievert on 6/11/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
import Accelerate

/// applies the function to every element of an array and takes only that argument. This is just a simple for-loop. If you want to use some custom fancy function, define it yourself.
func apply_function(function: Double->Double, x: matrix) -> matrix{
    var y = zeros(x.count)
    for i in 0..x.count{
        y[i] = function(x[i])
    }
    return y
}

//* real, imag, conj

func sin(x: matrix) -> matrix{
    var y = apply_function(sin, x)
    return y
}
func cos(x: matrix) -> matrix{
    var y = apply_function(cos, x)
    return y
}
func tan(x: matrix) -> matrix{
    var y = apply_function(tan, x)
    return y
}
/// log_e(.)
func log(x: matrix) -> matrix{
    var y = apply_function(log, x)
    return y
}
/// drops into objc
func abs(x: matrix) -> matrix{
    let N = x.count
    var arg1 = NSArray(array: x)
    
    var yy = abs_objc(arg1, CInt(N))
    var y = convertDoubleToMatrix(yy, N)
    return y
}
func sqrt(x: matrix) -> matrix{
    var y = apply_function(sqrt, x)
    return y
}
func floor(x: matrix) -> matrix{
    var y = apply_function(floor, x)
    return y
}
func ceil(x: matrix) -> matrix{
    var y = apply_function(ceil, x)
    return y
}
func pow(x: matrix, power: Double) -> matrix{
    var y = zeros(x.count)
    for i in 0..x.count{
        y[i] = pow(x[i], power)
    }
    return y
}
func sum(x: matrix) -> Double{
    var y = zeros(x.count)
    var s: Double = 0
    for i in 0..x.count{
        s = x[i] + s
    }
    return s
}
func avg(x: matrix) -> Double{
    var y: Double = sum(x)
    
    return y / x.count.double
}
func std(x: matrix) -> Double{
    var y: Double = avg(x)
    var z = x - y
    return sqrt(sum(pow(z, 2) / x.count.double))
}
/// variance used since var is a keyword
func variance(x: matrix) -> Double{
    var y: Double = avg(x)
    var z = x - y
    return sum(pow(z, 2) / x.count.double)
}
func l2norm(x: matrix) -> Double{
    return sqrt(sum(pow(x, 2)))
}
func l1norm(x: matrix) -> Double{
    return sqrt(sum(abs(x)))
}
func l0norm(x: matrix) -> Double{
    var norm = 0
    for i in 0..x.count{
        if x[i] != 0{
            norm += 1
        }
    }
    return norm.double
}

