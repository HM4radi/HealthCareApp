//
//  FirstViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PICircularProgressView.h"
#import "RTTableViewCell.h"
#import "RTStepCounter.h"
#import "RTSportPlanViewController.h"
#import "RTPlanData.h"
#import <AVOSCloud/AVOSCloud.h>
#import "RTDetailViewController.h"

@interface FirstViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,refreshData>
{
    UINavigationItem *navigationItem;
    PICircularProgressView *progressView;
    
    float progressNow;
    float complete;
    int tag;
    NSMutableArray *recordArray;
    
    UIScrollView* scrollView;
    
    int cellNum;
    int totalCalories;
    
    RTStepCounter *stepCounter;
    
    RTSportPlanViewController *sportPlanVC;
    RTPlanData *planData;
    
    RTDetailViewController *detailVC;
    
    NSDateFormatter *dateFormatter1;
    NSDateFormatter *dateFormatter2;
    NSDateFormatter *dateFormatter3;
    NSDateFormatter *dateFormatter4;
}

- (void)refreshTableView;

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationbar;

@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property int cellNum;

@property (weak, nonatomic) IBOutlet UILabel *navLabel;


@end
