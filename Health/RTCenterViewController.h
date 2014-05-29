//
//  RTCenterViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-26.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTfoodViewController.h"
#import "FirstViewController.h"
#import "RTPillsViewController.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
@interface RTCenterViewController : UIViewController{
    RTfoodViewController *foodViewController;
    FirstViewController *firstViewController;
    RTPillsViewController *pillsViewController;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (strong, nonatomic) IBOutlet UIView *baseView;

@property (strong, nonatomic) IBOutlet UIView *sportView;

@property (strong, nonatomic) IBOutlet UIView *ecpView;

@property (strong, nonatomic) IBOutlet UIView *foodView;

@property (strong, nonatomic) IBOutlet UIView *pillsView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet DPMeterView *shape1View;
@property (strong, nonatomic) IBOutlet DPMeterView *shape2View;
@property (strong, nonatomic) IBOutlet DPMeterView *shape3View;
@property (strong, nonatomic) IBOutlet DPMeterView *shape4View;
@property (weak, nonatomic) IBOutlet UILabel *navLabel;

@end
