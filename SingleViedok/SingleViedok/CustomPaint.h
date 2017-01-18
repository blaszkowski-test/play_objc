//
//  CustomPaint.h
//  SingleViedok
//
//  Created by LIM on 04.04.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface oneTouch : NSObject
{
    CGPoint touchBegin;
    CGPoint touchEnd;
    UIBezierPath * goPath;
}
@property CGPoint touchBegin;
@property CGPoint touchEnd;
@property UIBezierPath * goPath;
-(id) init;

@end

@interface CustomPaint : UIView
{
    NSMutableDictionary * touchMap;
}
@property NSMutableDictionary * touchMap;

@end