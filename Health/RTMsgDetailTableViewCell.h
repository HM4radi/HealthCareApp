//
//  RTMsgDetailTableViewCell.h
//  Health
//
//  Created by GeoBeans on 14-5-29.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTMsgDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *detialimage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
