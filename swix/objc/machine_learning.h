//
//  machine_learning.h
//  swix
//
//  Created by Scott Sievert on 6/30/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/core/core.hpp>
#import <opencv2/highgui/highgui.hpp>
#import <opencv2/ml/ml.hpp>

@interface SVM : NSObject

@property (strong, nonatomic) NSNumber* x;

- (void) train;
- (void) predict;

@end