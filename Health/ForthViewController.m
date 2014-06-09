//
//  ForthViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "ForthViewController.h"
#import "RTLoginViewController.h"
#import "RTAppDelegate.h"


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

- (IBAction)signOutsignOut:(id)sender {
    
    [AVUser logOut];  //清除缓存用户对象
    AVUser * currentUser = [AVUser currentUser];
    NSLog(@"CurrentUser:%@",currentUser.username);// 现在的currentUser是nil了
   
    [[RTMainViewController shareMainViewControllor] logout];
   
    //将自动登录设置为0
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    [mySettingData setBool:NO forKey:@"auto_login"];
    
    //重置用户个人信息输入页面判断 信息
    [mySettingData removeObjectForKey:@"CurrentUserProfileIsSetted"];
    
    //sync DB , and release if from memory 
    [NSUserDefaults resetStandardUserDefaults];
    

    
}
@end
