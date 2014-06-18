//
//  RTFamilyDetailViewController.h
//  Health
//
//  Created by Mac on 6/16/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTimeLineTableViewCell.h"

@interface RTFamilyDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *timeLineTableView;
@property (strong, nonatomic) IBOutlet UIView *view;

@end
