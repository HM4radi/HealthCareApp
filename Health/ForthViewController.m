//
//  ForthViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()

@end

@implementation ForthViewController

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
    
    [self.navigationbar setFrame:CGRectMake(0, 0, 320, 64)];
    //[self.navigationbar setBackgroundColor:[UIColor darkGrayColor]];
    self.navigationbar.translucent=YES;
    [_configScroll setContentSize:CGSizeMake(320, 666)];
    [_configScroll setFrame:CGRectMake(0, 64, 320, 504)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
