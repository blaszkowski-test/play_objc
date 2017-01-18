//
//  ViewController.m
//  SingleViedok
//
//  Created by LIM on 19.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import "SecondView.h"

@interface SecondView ()

@end

@implementation SecondView

@synthesize passedString;

- (void)viewDidLoad {
    [super viewDidLoad];
    tablicaObrazow = @[[UIImage imageNamed:@"mountain-03.jpg"],[UIImage imageNamed:@"gora2.jpg"]];
    
    touchArray = [NSMutableDictionary dictionary];
    
    [self.showName setText:passedString];
  
    paintInfo = [[CustomPaint alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    
    [self.view addSubview:paintInfo];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"Disappear secod view");
}

- (void) updateProgress
{
    [self.progressinfo setProgress:0.2];
    
    [NSThread detachNewThreadSelector:@selector(progressInThread) toTarget:self withObject:nil];
    
}

-(void) updateUiProgress
{
    float waitfor = self.progressinfo.progress;
    float goTo = 2 * waitfor;
    [self.progressinfo setProgress:goTo];
}

-(void) progressInThread
{
    
    int waitfor = 0;
    
    while(waitfor++ < 3)
    {
        [NSThread sleepForTimeInterval:2];
        [self performSelectorOnMainThread:@selector(updateUiProgress) withObject:nil waitUntilDone:YES];
    }
    
}

- (IBAction)changeValue:(id)sender forEvent:(UIEvent *)event {
    
    if(![sender isOn])
    {
        [self updateProgress];
        
        if(self.obrazek.animationImages == nil)
        {
            self.obrazek.animationImages = tablicaObrazow;
            self.obrazek.animationDuration = 2.0;
            [self.obrazek startAnimating];
        }
        else
        {
            [self.obrazek startAnimating];
        }
    }
    else
    {
        if(self.obrazek.animationImages != nil)
        {
            [self.obrazek stopAnimating];
        }
    }
}

- (IBAction)showDb:(id)sender forEvent:(UIEvent *)event {
    
    [self performSegueWithIdentifier:@"dbsegue" sender:self];
}
@end
