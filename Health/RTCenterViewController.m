//
//  RTCenterViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-26.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTCenterViewController.h"

@interface RTCenterViewController ()

@end

@implementation RTCenterViewController

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
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
    self.navBar.translucent=YES;
    self.navLabel.frame=CGRectMake(100,32,120,20);
    self.scrollView.frame=CGRectMake(0, 100, 320, 468);

    [self.view insertSubview:self.scrollView belowSubview:self.navBar];
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-self.navBar.frame.size.height-40);
    
    UIImageView * portraitView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 40, 100, 100)];
    [portraitView.layer setCornerRadius:CGRectGetHeight(portraitView.bounds)/2];
    portraitView.layer.borderColor = [UIColor blueColor].CGColor;
    //portraitView.layer.borderWidth = 0.5;
    [portraitView.layer setMasksToBounds:YES];
    [portraitView setImage:[UIImage imageNamed:@"1.jpg"]];
    [self.scrollView addSubview:portraitView];

    //血糖
    [self.shape1View setMeterType:DPMeterTypeLinearHorizontal];
    self.shape1View.progressTintColor = [UIColor colorWithRed:240.0/255.0 green:110.0/255.0 blue:113.0/255.0 alpha:1.0];
    self.shape1View.trackTintColor = [UIColor colorWithRed:222/255.f green:222/255.f blue:222/255.f alpha:1.f];
    [self.shape1View setShape:[UIBezierPath bezierPathWithRoundedRect:self.shape1View.bounds cornerRadius:0.f].CGPath];
    [self.shape1View.layer setBorderWidth:0.0f];
    [self.shape1View.layer setBorderColor:[UIColor colorWithRed:195/255.f green:129/255.f blue:35/255.f alpha:1.f].CGColor];
    [self updateProgressWithDelta:0.6 shapeView:self.shape1View animated:true];
    
    //血压——高压
    [self.shape2View setMeterType:DPMeterTypeLinearHorizontal];
    self.shape2View.progressTintColor =[UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];
    self.shape2View.trackTintColor = [UIColor colorWithRed:222/255.f green:222/255.f blue:222/255.f alpha:1.f];
    [self.shape2View setShape:[UIBezierPath bezierPathWithRoundedRect:self.shape2View.bounds cornerRadius:0.f].CGPath];
    [self.shape2View.layer setBorderWidth:0.0f];
    [self.shape2View.layer setBorderColor:[UIColor colorWithRed:195/255.f green:129/255.f blue:35/255.f alpha:1.f].CGColor];
    [self updateProgressWithDelta:0.8 shapeView:self.shape2View animated:true];

    //血压-低压
    [self.shape3View setMeterType:DPMeterTypeLinearHorizontal];
    self.shape3View.progressTintColor = [UIColor colorWithRed:225.0/255.0 green:240.0/255.0 blue:109.0/255.0 alpha:1.0];
    self.shape3View.trackTintColor = [UIColor colorWithRed:222/255.f green:222/255.f blue:222/255.f alpha:1.f];
    [self.shape3View setShape:[UIBezierPath bezierPathWithRoundedRect:self.shape3View.bounds cornerRadius:0.f].CGPath];
    [self.shape3View.layer setBorderWidth:0.0f];
    [self.shape3View.layer setBorderColor:[UIColor colorWithRed:195/255.f green:129/255.f blue:35/255.f alpha:1.f].CGColor];
    [self updateProgressWithDelta:0.5 shapeView:self.shape3View animated:true];
    
    //血氧
    [self.shape4View setMeterType:DPMeterTypeLinearHorizontal];
    self.shape4View.progressTintColor = [UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];
    self.shape4View.trackTintColor = [UIColor colorWithRed:222/255.f green:222/255.f blue:222/255.f alpha:1.f];
    [self.shape4View setShape:[UIBezierPath bezierPathWithRoundedRect:self.shape4View.bounds cornerRadius:0.f].CGPath];
    [self.shape4View.layer setBorderWidth:0.0f];
    [self.shape4View.layer setBorderColor:[UIColor colorWithRed:195/255.f green:129/255.f blue:35/255.f alpha:1.f].CGColor];
    [self updateProgressWithDelta:0.4 shapeView:self.shape4View animated:true];

    self.sportView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick2:)];
    [self.sportView addGestureRecognizer:tapGesture2];

    self.ecpView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick3:)];
    [self.ecpView addGestureRecognizer:tapGesture3];

    self.foodView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick4:)];
    [self.foodView addGestureRecognizer:tapGesture4];

    self.pillsView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick5:)];
    [self.pillsView addGestureRecognizer:tapGesture5];
}

- (void)updateProgressWithDelta:(CGFloat)delta shapeView:(DPMeterView*)shapeView animated:(BOOL)animated
{
        if (delta < 0) {
            [shapeView minus:fabs(delta) animated:animated];
        } else {
            [shapeView add:fabs(delta) animated:animated];
        }
}

- (void)viewClick1:(UITapGestureRecognizer *)gesture
{
    
}
- (void)viewClick2:(UITapGestureRecognizer *)gesture

{
    if (!firstViewController) {
        firstViewController=[[FirstViewController alloc]init];
    }
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:firstViewController.view];  }
                    completion:NULL];
    [UIView commitAnimations];
}

- (void)viewClick3:(UITapGestureRecognizer *)gesture
{
    
}
- (void)viewClick4:(UITapGestureRecognizer *)gesture
{
    if (!foodViewController) {
        foodViewController=[[RTfoodViewController alloc]init];
    }
    [UIView beginAnimations:@"view flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.view addSubview:foodViewController.view];  }
                    completion:NULL];
    [UIView commitAnimations];

}


- (void)viewClick5:(UITapGestureRecognizer *)gesture
{
        if (!pillsViewController) {
            pillsViewController=[[RTPillsViewController alloc]init];
        }
        [UIView beginAnimations:@"view flip" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView transitionWithView:self.view
                          duration:0.2
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{ [self.view addSubview:pillsViewController.view];  }
                        completion:NULL];
        [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
