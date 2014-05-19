//
//  GYBDetailViewController.h
//  TableView
//
//  Created by Mac on 5/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#import "GYBDetialView.h"

@interface GYBDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet GYBDetialView *detailView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;


@end
