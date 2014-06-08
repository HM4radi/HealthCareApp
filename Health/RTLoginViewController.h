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
#import <AVOSCloud/AVOSCloud.h>
#import "RTLoginBusiness.h"

@interface RTLoginViewController : UIViewController{
    NSMutableArray *_currentAccounts;
    RTLoginBusiness *loginer;
    RTLoginViewController *thisController;
}

@property (retain, nonatomic) IBOutlet UIImageView *login;
@property (retain, nonatomic) IBOutlet UIButton *dropButton;
@property (retain, nonatomic) IBOutlet UIView *moveDownGroup;
@property (retain, nonatomic) IBOutlet UIView *account_box;
- (IBAction)loginInput:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *loginInfoLabel;


@property (retain, nonatomic) IBOutlet UITextField *userNumber;
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;

@property (retain, nonatomic) IBOutlet UIImageView *userLargeHead;

-(BOOL)CheckCurrentUserAndLoadViewControllor;

+(id)shareLoginControllor;
@end
