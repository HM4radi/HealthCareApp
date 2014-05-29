//
//  RTSndMedicationViewController.m
//  Health
//
//  Created by Mac on 5/29/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTSndMedicationViewController.h"

@interface RTSndMedicationViewController ()

@end

@implementation RTSndMedicationViewController

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
    [self.navigationBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navigationBar.translucent=YES;
    self.navigationBar.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bacoToFormerView:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view.superview
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.view removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
}
@end
