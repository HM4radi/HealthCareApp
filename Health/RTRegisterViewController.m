//
//  RTRegisterViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-19.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTRegisterViewController.h"

@interface RTRegisterViewController ()

@end

@implementation RTRegisterViewController

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
    [self.view addSubview:loginNumber];
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)next:(id)sender {
    if (loginNumber.superview==self.view) {
        [loginNumber removeFromSuperview];
        [self.view addSubview:loginPass];
    }else
    {
        [self startRegister];
    }

}

- (void)startRegister
{
    
    //add register code
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
