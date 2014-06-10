//
//  RTAppDelegate.m
//  Health
//

//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTAppDelegate.h"
#import "AVIllness.h"
#import "RTUserProfileViewController.h"
#import "RTUserInfo.h"
#import "RTStepCounter.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0]

@implementation RTAppDelegate

static UIWindow *thiswindow=nil;
+(id)shareWindow
{

    if (thiswindow==nil) {
        thiswindow=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return thiswindow;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    RTLoginBusiness *loginBusiness=[[RTLoginBusiness alloc]init];
    //AVOS  TestObject
    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
  
    self.window =[RTAppDelegate shareWindow];
    
    
//判断是否存在当前用户
   
    if (loginBusiness.checkIfAuto_login) {
        UIViewController *Main=[RTMainViewController shareMainViewControllor];
        self.window.rootViewController =Main;
    }
    else
    {
        self.window.rootViewController =[RTLoginViewController shareLoginControllor];

    }
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)];
    
    //AVOS
    
    [AVOSCloud setApplicationId:@"fkpkteplejsdhh4gpwwgxhby59cr3858jvthfc34mgqyvya2"
                      clientKey:@"f23h6a0z598j9ftmck31mhk5ofxivj3y5eyvf0ib2ue86qh5"];
    
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //AVOS subclass register
    [AVIllness registerSubclass];
    [RTUserInfo registerSubclass];
    
    //网络连接监测
    self.isReachable=YES;
    self.beenReachable=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听，会启动一个run loop
    [self.internetReachability startNotifier];
    
    
    //计步器
    RTStepCounter *stepCounter=[RTStepCounter sharedRTSterCounter];
    [stepCounter startCounting];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [curReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    
    if(status == NotReachable)
    {
        if (self.isReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            self.isReachable = NO;
        }
        return;
    }
    if (status==ReachableViaWiFi||status==ReachableViaWWAN) {
        
        if (!self.isReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接信息" message:@"网络连接恢复" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            self.isReachable = YES;
        }
    }
}


// 微信分享
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    //NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"AppTerminate");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
