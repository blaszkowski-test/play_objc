//
//  TimerProtocol.m
//  SingleViedok
//
//  Created by LIM on 23.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import "TimerProtocol.h"

@implementation TimerClass

@synthesize delegate;

- (void) processComplete
{
    [[self delegate] processSuccess:YES];
}

- (void) startTimerDelegate
{
    timerPtr = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(processComplete) userInfo:nil repeats:YES];
}

- (void)stopTimerDelegate
{
    [timerPtr invalidate];
    timerPtr = nil;

}
@end