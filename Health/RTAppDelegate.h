//
//  RTAppDelegate.h
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLoginViewController.h"
#import "WXApi.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Reachability.h"
#import "RTLoginBusiness.h"

@interface RTAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    UIWindow *thiswindow;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *internetReachability;
@property (nonatomic) BOOL isReachable;
@property (nonatomic) BOOL beenReachable;

+(id)shareWindow;

@end
