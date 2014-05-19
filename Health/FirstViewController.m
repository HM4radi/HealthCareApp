//
//  FirstViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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
//    UIImageView *bkgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
//    [bkgView setImage:[UIImage imageNamed:@"Window Background@2x.png"]];
//    [self.view addSubview:bkgView];
    [self.navigationbar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navigationbar.translucent=YES;
    
//    [self.navigationbar setBackgroundColor: [UIColor colorWithRed:164/255.0 green:164/255.0 blue:0/255.0 alpha:1]];
    //[self.navigationbar setBackgroundImage:[UIImage imageNamed:@"navigationBarBackgroundRetro@2x.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"hello";
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
