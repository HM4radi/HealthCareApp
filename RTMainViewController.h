//
//  RTMainViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNGridMenu.h"
#import "RTCenterViewController.h"
#import "RTMsgViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "RTGYBNaviViewController.h"
#import "GYBTableViewController.h"
#import "RTShareMsg.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)
#define addHeight 88

@protocol tabbarDelegate <NSObject>

-(void)touchBtnAtIndex:(NSInteger)index;
-(void)touchCenterBtn;
@end

@class tabbarView;

@interface RTMainViewController : UIViewController<tabbarDelegate,RNGridMenuDelegate>


@property(nonatomic,strong) tabbarView *tabbar;
@property(nonatomic,strong) NSArray *arrayViewcontrollers;


@end
