//
//  RTSportPlanViewController.h
//  Health
//
//  Created by GeoBeans on 14-6-11.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMapView.h"

@interface RTSportPlanViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>{
    NSMutableArray *sportType;

    UIPickerView *typePicker;
    UIDatePicker *timePicker;
    UIActionSheet *actionView;
    
    RTMapView* _mapView;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;

@property (weak, nonatomic) IBOutlet UIView *sportTypeView;
@property (weak, nonatomic) IBOutlet UIView *sportTimeView;
@property (weak, nonatomic) IBOutlet UIView *sportLastView;

@end
