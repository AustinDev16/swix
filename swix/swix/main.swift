//
//  main.swift
//  swix
//
//  Created by Scott Sievert on 7/9/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

/* 
 *   some other useful tips that need an iOS app to use:
 *    1. UIImage to raw array[0]:
 *    2. raw array to UIImage[1]:
 *  
 *   for a working implementation, see[2] (to be published shortly)
 *  
 *   [0]:http://stackoverflow.com/a/1262893/1141256
 *   [1]:http://stackoverflow.com/a/12868860/1141256
 *   [2]:https://github.com/scottsievert/saliency/blob/master/AVCam/AVCam/saliency/imageToRawArray.m
 *
 *
 * For these tests, we're going to assume (dangerous I know) "easy" functions work like normal (abs, sum, pow, etc). It's the operators and stuff like that we want to test.
 */


/* TODO:
 *   * speed up operations
 *   * include eig
 */

import Foundation

// TESTS
var N = 10

func operator_test(){
    func operator2d_test(){
        var x = zeros((N,N)) + 10
        var y = 4+ones((N,N))
        assert(0.2 * x*y / 10 ~== ones((N,N)))
    }
    operator2d_test()
    var x = ones(N)
    var y = ones(N) * N.double
    assert(y / x ~== ones(N) * 10)
    println("    basic 1d and 2d operators work")
}
func scalar_test(){
    assert(Int(1) + Double(1) == 2)
    println("    Int(1)+Double(1)==2 through ScalarArithmetic")
}
func swift_complex_test(){
    var x = 1.0 + 1.0.i
    assert(abs(x) == sqrt(2))
    println("    scalar (not vector) complex number usage works using swift-complex.")
}
func range_test(){
    var x = arange(4)
    var y = x[0..<2]
    assert(y ~== arange(2))
    
    var z = zeros(4)
    z[0..<2] = ones(2)
    assert(z ~== array(1, 1, 0, 0))
    println("    x[0..<2] = ones(2) and y = z[3..<8] works in the 1d case!")
}
func argwhere_test(){
    var x = zeros(N)
    var y = zeros(N)
    x[0..<5] = ones(5)
    var i = argwhere(abs(x-y) < 1e-9)
    assert(i ~== array(5, 6, 7, 8, 9))
    x[argwhere(x<2)] = ones(argwhere(x<2).n)
    println("    can use argwhere. x[argwhere(x<2)]=zeros(argwhere(x<2).n)  works for both 1d and 2d.")
}
func matrix2d_indexing_test(){
    var x = array("1 2 3; 4 5 6; 7 8 9")
    x[0|2, 0|2] = array("4 3; 2 6")
    assert(x ~== array("4 3 3; 2 6 6; 7 8 9"))
    println("    use x[0|2, 0|2] to index *exclusively* (and 0!2 for inclusive)")
    println("    can use x[0|2, 1], x[1, 0..<2] or x[0..<2, 0|2] to also index")
}
func matrix2d_indexing_matrix_test(){
    var x = array("1 2 3; 4 5 6; 7 8 9")
    assert(x[array(0, 1, 2, 3, 4, 5)] ~== array(1, 2, 3, 4, 5, 6))
    println("    x[ndarray] works and indexes the ndarray row first")
}
func fft_test(){
    var x = arange(8)
    var (yr, yi) = fft(x)
    var x2 = ifft(yr, yi)
    assert(x2 ~== x)
    println("    fft/ifft works. fft(x) -> (yreal, yimag)")
}
func dot_test(){
    var x = eye(3) * 2
    var y = array("1 2 3 1; 4 5 6 1; 7 8 9 1")
    assert((x *! y) ~== 2*y)
    println("    dot product works with dot(x, y) or x *! y")
}
func svd_test(){
    var x = array("1 2; 4 8; 3 5")
    var (u, s, v) = svd(x)
    
    var y = array("1 2 3; 4 5 6")
    (u, s, v) = svd(y)

    var z = array("1 2 3; 4 5 6; 7 8 9")
    (u, s, v) = svd(z)
    
    println("    svd works and tested by hand for square, fat and skinny matrices against Python")
}
func svm_test(){
    var svm = SVM()
    var x = reshape(arange(4*2) , (4, 2))
    var y = array(0, 1, 2, 3)

    svm.train(x, y)
    var z = svm.predict(array(2, 3))
    assert(z == y[1])
    println("    svm works via simple test")
}
func inv_test(){
    var x = randn((4,4))
    var y = inv(x)
    assert((x *! y) ~== eye(4))
    println("    matrix inversion works")
}
func solve_test(){
    var A0 = array(1, 2, 3, 4, 2, 1, 4, 6, 7)
    var A = reshape(A0, (3, 3))
    var b = array(1, 2, 5)
    var x = solve(A, b)
    assert((A !/ b) ~== solve(A, b))
    println("    solve works, similar to Matlab's \\ operator (and checked by hand). Be careful -- this only works for nxn matrices")
}

println("running tests...")

runSimpleTests()
operator_test()
swift_complex_test()
scalar_test()
range_test()
argwhere_test()
matrix2d_indexing_test()
matrix2d_indexing_matrix_test()
fft_test()
dot_test()
svd_test()
svm_test()
inv_test()
solve_test()

var x_train:matrix = read_csv("../../../python_testing/csvs/x_train.csv")
var y_train:ndarray = read_csv("../../../python_testing/csvs/y_train.csv")
var x_test:matrix = read_csv("../../../python_testing/csvs/x_test.csv")

var svm = SVM()
svm.setParams("C_SVC", kernel_type: "SIGMOID")

svm.train(x_train, y_train)
var yhat = svm.predict(x_test)

// how accurate are we?
var y_test:ndarray = read_csv("../../../python_testing/csvs/y_test.csv")
var percent_correct:Double = argwhere(abs(y_test - yhat) < 0.5).n / yhat.n
println("\nPercent correct: \(percent_correct)")





