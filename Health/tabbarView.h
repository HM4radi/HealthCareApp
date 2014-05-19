//
//  tabbarView.h
//  Health
//
//  Created by GeoBeans on 14-5-14.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMainViewController.h"

@interface tabbarView : UIView

@property(nonatomic,strong) UIImageView *tabbarView;
@property(nonatomic,strong) UIImageView *tabbarViewCenter;

@property(nonatomic,strong) UIButton *button_1;
@property(nonatomic,strong) UIButton *button_2;
@property(nonatomic,strong) UIButton *button_3;
@property(nonatomic,strong) UIButton *button_4;
@property(nonatomic,strong) UIButton *button_center;

@property(nonatomic,weak) id<tabbarDelegate> delegate;

@end
