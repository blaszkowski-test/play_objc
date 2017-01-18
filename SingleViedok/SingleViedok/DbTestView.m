//
//  DbTestView.m
//  SingleViedok
//
//  Created by LIM on 07.03.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//
#import "DbTestView.h"

@interface DbTestView ()

@end

@implementation DbTestView

- (void)viewDidLoad
{
    [super viewDidLoad];
    database = [DbManager getSharedInstance];
    [self.tableText setDelegate:self];
    [self.tableText setDataSource:self];

    [self.CarTest setDelegate:self];
    [self.modelText setDelegate:self];
    [self.yearText setDelegate:self];
    
    [self.CarTest setReturnKeyType:UIReturnKeyDone];
    [self.modelText setReturnKeyType:UIReturnKeyDone];
    [self.yearText setReturnKeyType:UIReturnKeyDone];
    [self.yearText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    regexNumberOnly = [NSRegularExpression regularExpressionWithPattern:
                       @"([^0-9]+)" options:0 error:nil];

}

/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
*/
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@ %@ %lu %lu",[textField text],string,(unsigned long)range.location,(unsigned long)range.length);
    
    if([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"Disappear secod view");
}

- (IBAction)yearChange:(id)sender forEvent:(UIEvent *)event {

    
}

- (IBAction)tyearChanged:(id)sender forEvent:(UIEvent *)event {
    NSMutableString * buffer = [NSMutableString stringWithString:[self.yearText text]];
    
    NSString * modifiedString = [regexNumberOnly stringByReplacingMatchesInString:buffer options:0 range:NSMakeRange(0, [buffer length]) withTemplate:@""];
    
    if([modifiedString length] > 4)
    {
        [self.yearText setText:[modifiedString substringToIndex:4]];
    }
    else
    {
        [self.yearText setText:modifiedString];
    }
}

- (IBAction)carChanged:(id)sender forEvent:(UIEvent *)event {
    
    NSLog(@"%@",[self.CarTest text]);

}

- (IBAction)saveAction:(id)sender forEvent:(UIEvent *)event
{
    NSNumberFormatter * formatNumber = [[NSNumberFormatter alloc]init];
    long rowId =[database saveData:[self.CarTest text]
                  name:[self.modelText text]
                  year:[formatNumber numberFromString:[self.yearText text]]];
    formatNumber = nil;
    
    CarModel * oneCar = [[CarModel alloc]initWithName:[self.CarTest text] model:[self.modelText text] year:[formatNumber numberFromString:[self.yearText text]] key:[NSNumber numberWithLong: rowId]];
    
    [carsTable addObject:oneCar];
    
    [self.tableText reloadData];
}


- (IBAction)showAction:(id)sender
{ 
    carsTable = [database getAll];
    NSLog(@"COUNT %lu",(unsigned long)[carsTable count]);
    [self.tableText reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    long selectedRow = indexPath.row;
    NSLog(@"touch on row %lu", selectedRow);
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [carsTable count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleCell";
    
    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.TitleInfo.text = [[NSString alloc]initWithFormat:@"%@", [carsTable objectAtIndex:indexPath.row]];
    
    cell.LittleInfo.text = [NSString stringWithFormat:@"%@",[[carsTable objectAtIndex:indexPath.row]getId]];
    
    if(indexPath.row % 2 == 0 || indexPath.row == 0)
    {
        cell.imgShow.image = [UIImage imageNamed:@"mountain-03.jpg"];
    }
    else
    {
        cell.imgShow.image = [UIImage imageNamed:@"gora2.jpg"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    unsigned long currentIndex = indexPath.row;
    
    CarModel * buffer = [carsTable objectAtIndex:currentIndex];
    
    [database deleteCar:[buffer getId]];
    [carsTable removeObjectAtIndex:currentIndex];
    //NSLog(@"COUNT %lu",(unsigned long)[carsTable count]);
    
    // Request table view to reload
    [tableView reloadData];
}

@end
