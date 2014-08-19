//
//  twoD-math.swift
//  swix
//
//  Created by Scott Sievert on 7/10/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
import Accelerate

// UNOPTIMIZED: cumsum

func apply_function(function: ndarray->ndarray, x: matrix)->matrix{
    var y = function(x.flat)
    var z = zeros_like(x)
    z.flat = y
    return z
}
func sin(x: matrix) -> matrix{
    return apply_function(sin, x)
}
func cos(x: matrix) -> matrix{
    return apply_function(cos, x)
}
func tan(x: matrix) -> matrix{
    return apply_function(tan, x)
}
func log(x: matrix) -> matrix{
    return apply_function(log, x)
}
func abs(x: matrix) -> matrix{
    return apply_function(abs, x)
}
func sqrt(x: matrix) -> matrix{
    return apply_function(sqrt, x)
}
func floor(x: matrix) -> matrix{
    return apply_function(floor, x)
}
func ceil(x: matrix) -> matrix{
    return apply_function(ceil, x)
}
func round(x: matrix) -> matrix{
    return apply_function(round, x)
}
func sign(x: matrix) -> matrix{
    var y = apply_function(sign, x.flat)
    var z = zeros_like(x)
    z.flat = y
    return z
}

func pow(x: matrix, power: Double) -> matrix{
    var y = pow(x.flat, power)
    var z = zeros_like(x)
    z.flat = y
    return z
}
func min(x: matrix, absValue:Bool=false)-> Double{
    return min(x.flat)
}
func max(x: matrix, absValue:Bool=false)-> Double{
    return max(x.flat)
}
func min(x:matrix, y:matrix)->matrix{
    var z = zeros_like(x)
    z.flat = min(x.flat, y.flat)
    return z
}
func max(x:matrix, y:matrix)->matrix{
    var z = zeros_like(x)
    z.flat = max(x.flat, y.flat)
    return z
}
// we should take the norm over each row/column
//func norm(x: matrix, type:String="l2") -> Double{
//}
func sum(x: matrix, axis:Int = -1) -> ndarray{
    // arg dim: indicating what dimension you want to sum over. For example, if dim==0, then it'll sum over dimension 0 -- it will add all the numbers in the 0th dimension, x[0..<x.shape.0, i]
    assert(axis==0 || axis==1, "If you want to sum over the entire matrix, call `sum(x.flat)`.")
    if axis==0{
        var n = x.shape.1
        var m = ones((n,1))
        return (x *! m).flat
    }
    else {
        var n = x.shape.0
        var m = ones((1,n))
        return (m *! x).flat
    }
}
func avg(x:matrix, axis:Int = -1) -> ndarray{
    assert(axis==0 || axis==1, "If you want to find the average of the whole matrix call `avg(x.flat)`")
    var div = axis==0 ? x.shape.1 : x.shape.0
    return sum(x, axis:axis) / div.double
}

//func cumsum(x: matrix) -> matrix{
//    let N = x.count
//    var y = zeros(N)
//    for i in 0..<N{
//        if i==0      { y[i] = x[0]          }
//        else if i==1 { y[i] = x[0] + x[1]   }
//        else         { y[i] = x[i] + y[i-1] }
//    }
//    return y
//}













