//
//  GYBDetailViewController.m
//  TableView
//
//  Created by Mac on 5/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "GYBDetailViewController.h"
#import "GYBDetialView.h"
@interface GYBDetailViewController ()


@end

@implementation GYBDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.detailView init];
  
    [self.navigationBar setFrame:CGRectMake(0, 0, 320, 64)];
    //[self.navigationbar setBackgroundColor:[UIColor darkGrayColor]];
    self.navigationBar.translucent=YES;
    // shape 1 -- Heart
    [self.detailView.statusView setShape:[UIBezierPath heartShape:self.detailView.statusView.frame].CGPath];
    self.detailView.statusView.progressTintColor = [UIColor colorWithRed:189/255.f green:32/255.f blue:49/255.f alpha:1.f];
    
    [self.detailView updateProgressWithDelta:0.6 animated:YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
