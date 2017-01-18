//
//  DbTestView.h
//  SingleViedok
//
//  Created by LIM on 07.03.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
#import "SimpleCell.h"

@interface DbTestView : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    DbManager * database;
    NSMutableArray * carsTable;
    NSRegularExpression *regexNumberOnly;
}
@property (strong, nonatomic) IBOutlet UITextField *CarTest;
@property (strong, nonatomic) IBOutlet UITextField *modelText;
@property (strong, nonatomic) IBOutlet UITextField *yearText;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *showButton;

@property (strong, nonatomic) IBOutlet UITableView *tableText;
- (IBAction)yearChange:(id)sender forEvent:(UIEvent *)event;
- (IBAction)tyearChanged:(id)sender forEvent:(UIEvent *)event;

- (IBAction)carChanged:(id)sender forEvent:(UIEvent *)event;

- (IBAction)saveAction:(id)sender forEvent:(UIEvent *)event;
- (IBAction)showAction:(id)sender;


@end