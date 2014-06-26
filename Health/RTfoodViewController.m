//
//  RTfoodViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-26.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTfoodViewController.h"

@interface RTfoodViewController ()

@end

@implementation RTfoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navBar.translucent=YES;
    self.scrollView.frame=CGRectMake(0, 64, 320, 504);
    self.scrollView.contentSize=self.view.frame.size;
    self.scrollView.userInteractionEnabled=YES;
    self.backBtn.frame=CGRectMake(10, 10, 44, 44);
    self.navLabel.frame=CGRectMake(100,32,120,20);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.



}


- (IBAction)touchBack:(id)sender {
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view.superview
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.view removeFromSuperview];  }
                    completion:NULL];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
