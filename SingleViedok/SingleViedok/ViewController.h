//
//  ViewController.h
//  SingleViedok
//
//  Created by LIM on 19.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerProtocol.h"
#import "urlTest.h"

@interface ViewController : UIViewController<TimerDelegate, urlTestDelegate,UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * tablica;
    NSMutableArray * agentTable;
    TimerClass * Czas;
    urlTest * urlContent;
 
}
@property (strong, nonatomic) IBOutlet UIButton *StartCzasu;
@property (strong, nonatomic) IBOutlet UITextField *Pole;
@property (strong, nonatomic) IBOutlet UILabel *Napisik;
@property (strong, nonatomic) IBOutlet UIButton *Guziczek;
@property (strong, nonatomic) IBOutlet UITextView *poleTekstowe;
@property (strong, nonatomic) IBOutlet UITableView *testTable;

- (IBAction)StartTImer:(id)sender;
- (IBAction)Nacisk:(id)sender forEvent:(UIEvent *)event;
- (IBAction)Show:(id)sender;
- (IBAction)hideKeyboard:(id)sender forEvent:(UIEvent *)event;


@end

