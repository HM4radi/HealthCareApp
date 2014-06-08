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

@interface RTAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    UIWindow *thiswindow;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

+(id)shareWindow;

@end
