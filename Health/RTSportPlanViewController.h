//
//  RTSportPlanViewController.h
//  Health
//
//  Created by GeoBeans on 14-6-11.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMapView.h"
#import "RTPlanData.h"
#import <AVOSCloud/AVOSCloud.h>
@protocol refreshData <NSObject>
@required
- (void)refreshTableView;
@end

@interface RTSportPlanViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>{
    NSMutableArray *sportType;

    UIPickerView *typePicker;
    UIDatePicker *timePicker;
    UIActionSheet *actionView;
    
    NSString *selectedType;
    
    RTMapView* _mapView;
    
    NSDateFormatter *dateFormatter1;
    NSDateFormatter *dateFormatter2;
    NSDateFormatter *dateFormatter3;
    NSDateFormatter *dateFormatter4;
    
    //NSArray *routeCoord;
    RTPlanData *planData;
    
    BOOL finished;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;

@property (weak, nonatomic) IBOutlet UIView *sportTypeView;
@property (weak, nonatomic) IBOutlet UIView *sportTimeView;
@property (weak, nonatomic) IBOutlet UIView *sportLastView;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectRoute;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@property(nonatomic,weak) id<refreshData> dataDelegate;

@end
