//
//  CustomPaint.m
//  SingleViedok
//
//  Created by LIM on 04.04.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//

#import "CustomPaint.h"

@implementation oneTouch

-(id) init
{
    self = [super init];
    
    if(self)
    {
        self.goPath = [UIBezierPath bezierPath];
    }
    
    return self;
}

@synthesize touchBegin;
@synthesize touchEnd;
@synthesize goPath;

@end

@implementation CustomPaint

@synthesize touchMap;

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        self.multipleTouchEnabled = YES;
    }
    
    touchMap = [NSMutableDictionary dictionary];
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext, [[UIColor blueColor] CGColor]);
    CGContextSetLineWidth(currentContext, 3.0);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound); 
    CGContextBeginPath(currentContext);
    
    for(NSNumber * t in touchMap)
    {
        CGContextAddPath(currentContext, [[[touchMap objectForKey:t]goPath ]CGPath]);
        CGContextDrawPath(currentContext, kCGPathStroke);
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    for(UITouch * t in touches)
    {
        oneTouch * tmp = [[oneTouch alloc]init];
        
        tmp.touchBegin = [t locationInView:self];
        
        [touchMap setObject:tmp forKey:[NSNumber numberWithUnsignedLong:(unsigned long)[t hash]]];
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for(UITouch * t in touches)
    {
        oneTouch * tmp = [touchMap objectForKey:[NSNumber numberWithUnsignedLong:(unsigned long)[t hash]]];
        tmp.touchEnd = [t locationInView:self];
        [tmp.goPath moveToPoint:tmp.touchBegin];
        [tmp.goPath addLineToPoint:tmp.touchEnd];
        tmp.touchBegin = tmp.touchEnd;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //for(UITouch * t in touches)
    //{
    //[paintInfo.touchMap removeObjectForKey:[NSNumber numberWithUnsignedLong:(unsigned long)[t hash]]];
    //}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //for(UITouch * t in touches)
    //{
    //[paintInfo.touchMap removeObjectForKey:[NSNumber numberWithUnsignedLong:(unsigned long)[t hash]]];
    //}
}

@end
