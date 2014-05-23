//
//  RTTableViewCell.h
//  Health
//
//  Created by GeoBeans on 14-5-21.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *steps;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *calories;

@end
