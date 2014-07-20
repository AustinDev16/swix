//
//  fullTests.swift
//  swix
//
//  Created by Scott Sievert on 7/18/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation

class runSimpleTests {
    var N:Int
    init(){
        self.N = 10
        operatorTests()
        comparisonTests()
        functionTests()
    }
    func functionTests(){
        var x = array(-1, 0, 1)
        
        assert(abs(x) ~== array(1, 0, 1))
        assert(sign(x+0.1) ~== array(-1, 1, 1))
        assert(sum(x+1)     == 3)
        assert(cumsum(x+1) ~== array(0, 1, 3))
        assert(pow(x+1, 2) ~== array(0, 1, 4))
        assert(((x+1)^2)   ~== array(0, 1, 4))
        assert(min(x) == -1)
        assert(max(x) == 1)
        assert(variance(ones(4)) == 0)
        assert(std(ones(4)) == 0)
        assert(avg(x) == 0)
        assert(abs(avg(rand(1000)) - 0.5) < 0.1)
        assert(abs(avg(randn(1000))) < 0.1)
        assert(abs(std(randn(1000)) - 1) < 0.2)
        var y = randn((100,100))
        assert(abs(avg(y.flat)) < 0.1)
        y = rand((100, 100))
        assert(abs(avg(y.flat) - 0.5) < 0.1)
    }
    func operatorTests(){
        // l and o similar to 1 and 0
        var l = ones(N)
        var o = zeros(N)
        
        // PLUS
        assert((o+1.double) ~== l)
        assert((1.double+o) ~== l)
        assert((l+o) ~== l)
        
        // MINUS
        assert((l - o) ~== l)
        assert((l - 1) ~== o)
        assert((1 - o) ~== l)
        
        // MULTIPLY
        assert(((o+1) * l) ~== l)
        assert((l * 1) ~== l)
        assert((1 * l) ~== l)
        
        // DIVIDE
        assert(((l+1)/2) ~== l)
        assert((o/l) ~== o)
        assert((1 / l) ~== l)
        
        // POW
        assert((array(1, 2, 3)^2) ~== array(1, 4, 9))
    }
    func comparisonTests(){
        //     true:  <, >, <=, >=, ==, !==
        var x = array(0, 3,  3,  4,  5,  7)
        var y = array(1, 2,  3,  4,  5,  6)
        
        // matrix <op> matrix
        assert((x < y) ~== array(1, 0, 0, 0, 0, 0))
        assert((x > y) ~== array(0, 1, 0, 0, 0, 1))
        assert((x <= y) ~== array(1, 0, 1, 1, 1, 0))
        assert((x >= y) ~== array(0, 1, 1, 1, 1, 1))
//        assert((x == y) ~== array(0, 0, 1, 1, 1, 0))
//        assert((x != y) ~== array(1, 1, 0, 0, 0, 1))
        
        // double <op> matrix
        assert((4 < x) ~== array(0, 0, 0, 0, 1, 1))
        assert((4 > x) ~== array(1, 1, 1, 0, 0, 0))
        assert((4 >= x) ~== array(1, 1, 1, 1, 0, 0))
        assert((4 <= x) ~== array(0, 0, 0, 1, 1, 1))
        
        // matrix <op> ouble
        assert((x > 4) ~== array(0, 0, 0, 0, 1, 1))
        assert((x < 4) ~== array(1, 1, 1, 0, 0, 0))
        assert((x <= 4) ~== array(1, 1, 1, 1, 0, 0))
        assert((x >= 4) ~== array(0, 0, 0, 1, 1, 1))
    }
}













