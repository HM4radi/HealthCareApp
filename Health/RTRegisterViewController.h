//
//  RTRegisterViewController.h
//  Health
//
//  Created by GeoBeans on 14-5-19.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "RTLoginBusiness.h"
#import "RTRegistBussiness.h"

@interface RTRegisterViewController : UIViewController
<UITextFieldDelegate>
{
    IBOutlet UIView *loginNumber;
    IBOutlet UIView *loginPass;
    RTRegistBussiness *Register;
}
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *registBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneInputField;
@property (strong, nonatomic) IBOutlet UITextField *passwordInputField;
@property (strong, nonatomic) IBOutlet UITextField *emailInputField;
@property (strong, nonatomic) IBOutlet UIImageView *phoneInputTextBorderView;
@property (strong, nonatomic) IBOutlet UITextField *pwdAgainInputTextField;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;



- (IBAction)doRegist:(id)sender;
- (IBAction)checkPhoneNumber:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)checkEmail:(id)sender;
- (IBAction)checkPassword:(id)sender;
- (IBAction)checkUsername:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *finishRegistBtn;


@property (strong, nonatomic) IBOutlet UITextField *usernameInputField;

@property (strong, nonatomic) IBOutlet UILabel *registFeedBack;

@property (strong, nonatomic) IBOutlet UIButton *upLoadImageBtn;

//验证信息提示
@property (strong, nonatomic) IBOutlet UILabel *usernameCheckInfo;

@property (strong, nonatomic) IBOutlet UILabel *emailCheckInfo;


@property (strong, nonatomic) IBOutlet UILabel *pwdCheckInfo;


@property (strong, nonatomic) IBOutlet UIImageView *emailInputFieldBorder;
@property (strong, nonatomic) IBOutlet UIImageView *pwdInputFieldBorderView;
@property (strong, nonatomic) IBOutlet UIImageView *usernameInputFieldBorder;
@property (strong, nonatomic) IBOutlet UIImageView *pwdAgainInputFieldBorder;
- (IBAction)upLoadImagesAction:(id)sender;

@end
