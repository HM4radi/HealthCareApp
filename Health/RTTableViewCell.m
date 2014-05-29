//
//  RTTableViewCell.m
//  Health
//
//  Created by GeoBeans on 14-5-21.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTTableViewCell.h"

@implementation RTTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [self.portraitView.layer setCornerRadius:CGRectGetHeight(self.portraitView.bounds)/2];
    //self.portraitView.layer.borderColor = [UIColor blueColor].CGColor;
    //portraitView.layer.borderWidth = 0.5;
    [self.portraitView.layer setMasksToBounds:YES];
    [self.portraitView setImage:[UIImage imageNamed:@"1.jpg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
