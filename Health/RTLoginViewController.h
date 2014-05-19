//
//  RTLoginViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-19.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMainViewController.h"
#import "RTRegisterViewController.h"

@interface RTLoginViewController : UIViewController{
    NSMutableArray *_currentAccounts;
}

@property (retain, nonatomic) IBOutlet UIButton *login;
@property (retain, nonatomic) IBOutlet UIButton *dropButton;
@property (retain, nonatomic) IBOutlet UIView *moveDownGroup;
@property (retain, nonatomic) IBOutlet UIView *account_box;


@property (retain, nonatomic) IBOutlet UITextField *userNumber;
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;

@property (retain, nonatomic) IBOutlet UIImageView *userLargeHead;
@end
