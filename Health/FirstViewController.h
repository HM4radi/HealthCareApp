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
#import "RTMapView.h"
#import "BEMSimpleLineGraphView.h"
#import "RTStepCounter.h"
#import "RTSportPlanViewController.h"
#import "RTPlanData.h"
@interface FirstViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,BEMSimpleLineGraphDelegate>
{
    UINavigationItem *navigationItem;
    PICircularProgressView *progressView;
    
    float progressNow;
    float complete;
    int tag;
    NSMutableArray *recordArray;
    RTMapView* _mapView;
    
    int cellNum;
    int totalCalories;
    
    CLLocationCoordinate2D *route;
    int routeCount;
    int currentIndex;
    QPointAnnotation* currentAnno;
    RTStepCounter *stepCounter;
    
    RTSportPlanViewController *sportPlanVC;
    RTPlanData *planData;
}

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationbar;

@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UINavigationBar *detailNavBar;

@property int cellNum;

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;
@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;
@property (weak, nonatomic) IBOutlet UINavigationItem *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *navLabel;

@property (weak, nonatomic) IBOutlet UILabel *navLabel1;

@end
