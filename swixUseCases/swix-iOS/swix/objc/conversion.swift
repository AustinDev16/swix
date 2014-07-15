//
//  conversion.swift
//  swix
//
//  Created by Scott Sievert on 7/11/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
import Accelerate

func matrixToPointer(x: matrix)->UnsafePointer<Double>{
    // sustains since objc rewrites raw memory!
    return UnsafePointer<Double>(x.grid)
}
func matrixToPointer(x: [Int])->UnsafePointer<Int>{
    // sustains since objc rewrites raw memory!
    return UnsafePointer<Int>(x)
}
func pointerTo2DMatrix(xPC: UnsafePointer<Double>, N: CInt, M:CInt) -> matrix2d{
    var x = zeros((N.int, M.int))
    var xP = matrixToPointer(x.flat)
    xP = xPC;
    return x
}