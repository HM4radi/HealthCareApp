//
//  RTDetailViewController.h
//  Health
//
//  Created by GeoBeans on 14-6-17.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"
#import "RTMapView.h"
#import "RTPlanData.h"

@interface RTDetailViewController : UIViewController<BEMSimpleLineGraphDelegate>
{
    RTMapView* _mapView;
    CLLocationCoordinate2D *route;
    int routeCount;
    int currentIndex;
    QPointAnnotation* currentAnno;
    RTPlanData *planData;
}

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *navLabel;
@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sportTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sportStrengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *sportCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *sportLocationLabel;
@property (strong, nonatomic) IBOutlet UIView *infoView;

@end
