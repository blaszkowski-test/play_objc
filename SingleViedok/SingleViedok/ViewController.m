//
//  ViewController.m
//  SingleViedok
//
//  Created by LIM on 19.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import "ViewController.h"
#import "SecondView.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) urlResponse:(NSMutableArray *)data
{
    //[self.testTable set]
    
    agentTable = [[NSMutableArray alloc]initWithArray:data];
    data = nil;
    
    /*NSMutableString * tekscik = [[NSMutableString alloc] init];
     for(NSDictionary * agent in agentTable)
     {
     for (NSString * key in agent) {
     
     [tekscik appendString:[NSString stringWithFormat:@" %@ => %@ \n",key,agent[key]]];
     }
     }
     [self.poleTekstowe setText:tekscik];
     tekscik = nil;*/
    
    
    [self.testTable reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    long selectedRow = indexPath.row;
    NSLog(@"touch on row %lu", selectedRow);
   // [self.testTable setEditing:YES animated:YES];
    [self performSegueWithIdentifier:@"DetailSecond" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",[segue identifier]);
    
    NSIndexPath *indexPath = [self.testTable indexPathForSelectedRow];
    
    
    @try {
        if ([segue.destinationViewController respondsToSelector:@selector(setPassedString:)]) {
            [segue.destinationViewController performSelector:@selector(setPassedString:)
                                                  withObject:[[agentTable objectAtIndex:indexPath.row] objectForKey:@"ag_first_name"]];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [agentTable count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"%@ %@", [[agentTable objectAtIndex:indexPath.row] objectForKey:@"ag_first_name"],[[agentTable objectAtIndex:indexPath.row] objectForKey:@"ag_last_name"]];
    
    cell.detailTextLabel.text = @"More text";
    cell.imageView.image = [UIImage imageNamed:@"flvico.png"];
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) processSuccess:(BOOL)success
{
    [self.Napisik setText:[NSString stringWithFormat:@" %@ ",[NSDate date]]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"VIEW APPEAR");
    
    NSIndexPath *indexPath = [self.testTable indexPathForSelectedRow];
    [self.testTable deselectRowAtIndexPath:indexPath animated:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAllert)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tablica = [NSMutableArray array];
    [self.testTable setDelegate:self];
    [self.testTable setDataSource:self];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.Napisik.text = @"Pamiec pada";
    // Dispose of any resources that can be recreated.
}
- (IBAction)Nacisk:(id)sender forEvent:(UIEvent *)event {
    
    [tablica addObject:[self.Pole text]];
    
    [self.Pole setText:@""];
}

- (IBAction)Show:(id)sender {
    NSMutableString * buffor = [NSMutableString string];
    
    for(NSString * element in tablica)
    {
        [buffor appendFormat:@" %@ ",element];
    }
    
    [self.Napisik setText:buffor];
    
    urlContent = [[urlTest alloc] init];
    [urlContent setDelegate:self];
    [urlContent startTest];
    
}

- (IBAction)hideKeyboard:(id)sender forEvent:(UIEvent *)event {
    
    [sender resignFirstResponder];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.Pole isFirstResponder] && [touch view] != self.Pole)
    {
        [self.Pole resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void) addAllert
{
    [self performSegueWithIdentifier:@"DetailSecond" sender:self];
}

- (IBAction)StartTImer:(id)sender {
    
    if(Czas == nil)
    {
        Czas = [[TimerClass alloc]init];
        [Czas setDelegate:self];
        [Czas startTimerDelegate];
        
        [self.StartCzasu setTitle:@"exec" forState:UIControlStateNormal];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Press button" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }
    else
    {
        [Czas stopTimerDelegate];
        Czas = nil;
        
        [self.StartCzasu setTitle:@"Timer" forState:UIControlStateNormal];
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.Pole setText: [NSString stringWithFormat:@"%lu", (unsigned long)buttonIndex]];
}
@end
