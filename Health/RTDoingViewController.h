//
//  RTDoingViewController.h
//  Health
//
//  Created by GeoBeans on 14-6-24.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMapView.h"
#import "RTPlanData.h"
#import "ACPButton.h"
#import "RTSportRecord.h"

@interface RTDoingViewController : UIViewController{
    RTMapView *_mapView;
    RTPlanData *planData;
    CLLocationCoordinate2D *route;
    QPointAnnotation* currentAnno;
    NSTimer *timer;
    long seconds;
    BOOL started;
    int timeLoop;
    RTSportRecord *sportRecord;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet ACPButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distLabel;

@property (weak, nonatomic) IBOutlet UILabel *calLabel;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@end
