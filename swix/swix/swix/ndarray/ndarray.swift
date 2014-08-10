//
//  initing.swift
//  swix
//
//  Created by Scott Sievert on 7/9/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
import Accelerate

// the matrix definition and related functions go here

// SLOW PARTS: x[ndarray, ndarray] set, modulo operator


struct ndarray {
    let n: Int
    var count: Int
    var grid: [Double]
    init(n: Int) {
        self.n = n
        self.count = n
        grid = Array(count: n, repeatedValue: 0.0)
    }
    func reshape(shape: (Int,Int)) -> matrix{
        assert(shape.0 * shape.1 == n, "Number of elements must not change.")
        var y:matrix = zeros(shape)
        y.flat = self
        return y
    }
    func copy() -> ndarray{
        var y = zeros(n)
        cblas_dcopy(self.n.cint, !self, 1.cint, !y, 1.cint)
        return y
    }
    func indexIsValidForRow(index: Int) -> Bool {
        return index >= 0 && index < n
    }
    func min() -> Double{
        return min_objc(!self, n.cint)
    }
    func max() -> Double{
        return max_objc(!self, n.cint)
    }
    func mean() -> Double{
        return avg(self)
    }
    subscript(index: Int) -> Double {
        get {
            assert(indexIsValidForRow(index), "Index out of range")
            return grid[index]
        }
        set {
            assert(indexIsValidForRow(index), "Index out of range")
            grid[index] = newValue
        }
    }
    subscript(r: Range<Int>) -> ndarray {
        get {
            // assumes that r is not [0, 1, 2, 3...] not [0, 2, 4...]
            return self[toArray(r)]
        }
        set {
            self[toArray(r)].grid = newValue.grid}
    }
    subscript(r: ndarray) -> ndarray {
        get {
            //assert((r%1.0) ~== zeros_like(r))
            // ndarray has fractional parts, and those parts get truncated
            // dropped for speed results (depends on for-loop in C)
            assert((r.max().int < self.n) && (r.min() >= 0), "An index is out of bounds")
            var y = zeros(r.n)
            index_objc(!self, !y, !r, r.n.cint)
            return y
        }
        set {
            assert((r.max().int < self.n) && (r.min() >= 0), "An index is out of bounds")
            // asked stackoverflow question at [1]
            // [1]:http://stackoverflow.com/questions/24727674/modify-select-elements-of-an-array
            // tried basic optimization myself, but the compiler took care of that.
            index_xa_b_objc(!self, !r, !newValue, r.n.cint)
        }
    }
}

















