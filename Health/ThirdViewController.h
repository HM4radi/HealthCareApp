//
//  ThirdViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"
#import "RTMapView.h"
#import "GYBTableViewController.h"

@interface ThirdViewController : UIViewController<RNFrostedSidebarDelegate>{
    RTMapView* _mapView;
}

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationbar;
@property (retain, nonatomic) IBOutlet UIButton *sidebarBtn;
@property(nonatomic, retain) RTMapView* _mapView;
@end
