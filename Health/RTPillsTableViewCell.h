//
//  RTPillsTableViewCell.h
//  Health
//
//  Created by GeoBeans on 14-5-27.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPillsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *pillsName;

@property (weak, nonatomic) IBOutlet UILabel *pillsTime;

@property (weak, nonatomic) IBOutlet UILabel *pillsFood;

@property (weak, nonatomic) IBOutlet UILabel *pillsNum;

@property (weak, nonatomic) IBOutlet UISwitch *pillsCmp;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;

@end
