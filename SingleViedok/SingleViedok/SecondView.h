//
//  ViewController.h
//  SingleViedok
//
//  Created by LIM on 19.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPaint.h"
@interface SecondView : UIViewController
{
    NSArray * tablicaObrazow;
    NSMutableDictionary * touchArray;
    CustomPaint * paintInfo;
}
@property (strong, nonatomic) IBOutlet UISwitch *train;
@property (strong, nonatomic) IBOutlet UIImageView *obrazek;
@property NSString * passedString;
@property (strong, nonatomic) IBOutlet UILabel *showName;
@property (strong, nonatomic) IBOutlet UIButton *GotoDb;
@property (strong, nonatomic) IBOutlet UIProgressView *progressinfo;

- (IBAction)changeValue:(id)sender forEvent:(UIEvent *)event;
- (IBAction)showDb:(id)sender forEvent:(UIEvent *)event;

@end
