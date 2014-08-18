//
//  matrix2d.swift
//  swix
//
//  Created by Scott Sievert on 7/9/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
import Accelerate
struct matrix {
    let n: Int
    var rows: Int
    var columns: Int
    var count: Int
    var shape: (Int, Int)
    var flat:ndarray
    var T:matrix {return transpose(self)}
    var I:matrix {return inv(self)}
    var pI:matrix {return pinv(self)}
    init(columns: Int, rows: Int) {
        self.n = rows * columns
        self.rows = rows
        self.columns = columns
        self.shape = (rows, columns)
        self.count = n
        self.flat = zeros(rows * columns)
        
    }
    func copy()->matrix{
        var y = zeros_like(self)
        y.flat = self.flat.copy()
        return y
    }
    subscript(i: String) -> ndarray {
        get {
            assert(i == "diag", "Currently the only support x[string] is x[\"diag\"]")
            var size = rows < columns ? rows : columns
            var i = arange(size)
            return self[i*columns.double + i]
        }
        set {
            assert(i == "diag", "Currently the only support x[string] is x[\"diag\"]")
            var m = shape.0
            var n = shape.1
            var min_mn = m < n ? m : n
            var j = n.double * arange(min_mn)
            self[j + j/n.double] = newValue
        }
    }
    func indexIsValidForRow(r: Int, c: Int) -> Bool {
        return r >= 0 && r < rows && c>=0 && c < columns
    }
    func dot(y: matrix) -> matrix{
        return self *! y
    }
    subscript(i: Int, j: Int) -> Double {
        get {
            var nI = i
            var nJ = j
            if nI < 0 {nI = rows + i}
            if nJ < 0 {nJ = rows + j}
            assert(indexIsValidForRow(nI, c:nJ), "Index out of range")
            return flat[nI * columns + nJ]
        }
        set {
            var nI = i
            var nJ = j
            if nI < 0 {nI = rows + i}
            if nJ < 0 {nJ = rows + j}
            assert(indexIsValidForRow(nI, c:nJ), "Index out of range")
            flat[nI * columns + nJ] = newValue
        }
    }
    subscript(r: Range<Int>, c: Range<Int>) -> matrix {
        get {
            var rr = asarray(r)
            var cc = asarray(c)
            return self[rr, cc]
        }
        set {
            var rr = asarray(r)
            var cc = asarray(c)
            self[rr, cc] = newValue
        }
    }
    subscript(or: ndarray, oc: ndarray) -> matrix {
        get {
            var r = or.copy()
            var c = oc.copy()
            if r.max() < 0.0 {r += 1.0 * rows}
            if c.max() < 0.0 {c += 1.0 * columns}
            
            var (j, i) = meshgrid(r, c)
            var idx = (j.flat*columns.double + i.flat)
            var z = flat[idx]
            var zz = reshape(z, (r.n, c.n))
            return zz
        }
        set {
            var r = or.copy()
            var c = oc.copy()
            if r.max() < 0.0 {r += 1.0 * rows}
            if c.max() < 0.0 {c += 1.0 * columns}
            if r.n > 0 && c.n > 0{
                var (j, i) = meshgrid(r, c)
                var idx = j.flat*columns.double + i.flat
                flat[idx] = newValue.flat
            }
        }
    }
    subscript(r: ndarray) -> ndarray {
        get {return self.flat[r]}
        set {self.flat[r] = newValue }
    }
    subscript(i: Range<Int>, k: Int) -> ndarray {
        get {
            var idx = asarray(i)
            return self[idx, k]
        }
        set {
            var idx = asarray(i)
            self[idx, k] = newValue
        }
    }
    subscript(i: ndarray, k: Int) -> ndarray {
        get {
            var idx = i.copy()
            var x:ndarray = self.flat[idx * self.columns.double + k.double]
            return x
        }
        set {
            var idx = i.copy()
            self.flat[idx * self.columns.double + k.double] = newValue
        }
    }
    subscript(i: Int, k: Range<Int>) -> ndarray {
        get {
            var idx = asarray(k)
            return self[i, idx]
        }
        set {
            var idx = asarray(k)
            self[i, idx] = newValue
        }
    }
    subscript(i: Int, k: ndarray) -> ndarray {
        get {
            var x:ndarray = self.flat[i.double * self.columns.double + k]
            return x
        }
        set {
            self.flat[i.double * self.columns.double + k] = newValue
        }
    }
}

















