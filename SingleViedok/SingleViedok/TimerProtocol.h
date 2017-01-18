//
//  TimerProtocol.h
//  SingleViedok
//
//  Created by LIM on 23.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimerDelegate <NSObject>
@required
- (void) processSuccess: (BOOL)success;
@end

@interface TimerClass : NSObject
{
    id <TimerDelegate> delegate;
    NSTimer * timerPtr;
}
@property id delegate;
- (void) startTimerDelegate;
- (void) processComplete;
- (void) stopTimerDelegate;
@end
