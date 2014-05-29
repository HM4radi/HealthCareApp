//
//  RTPillsTableViewCell.m
//  Health
//
//  Created by GeoBeans on 14-5-27.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTPillsTableViewCell.h"

@implementation RTPillsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    [self.pillsCmp addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
}

-(void)switchAction:(id)sender{
    if (self.pillsCmp.on==false) {
        UIColor *col1=[UIColor lightGrayColor];
        self.lbl1.textColor=col1;
        self.lbl2.textColor=col1;
        self.lbl3.textColor=col1;
        self.lbl4.textColor=col1;
        self.pillsFood.textColor=col1;
        self.pillsName.textColor=col1;
        self.pillsNum.textColor=col1;
        self.pillsTime.textColor=col1;
    }else{
        UIColor *col2=[UIColor colorWithRed:130.0/255.0 green:190.0/255.0 blue:20.0/255.0 alpha:1.0];
        self.lbl1.textColor=col2;
        self.lbl2.textColor=col2;
        self.lbl3.textColor=col2;
        self.lbl4.textColor=col2;
        self.pillsFood.textColor=col2;
        self.pillsName.textColor=col2;
        self.pillsNum.textColor=col2;
        self.pillsTime.textColor=col2;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
