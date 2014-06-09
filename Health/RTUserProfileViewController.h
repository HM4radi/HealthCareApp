//
//  RTUserProfileViewController.h
//  Health
//
//  Created by Mac on 6/5/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTUserInfo.h"
#import "RTLoginBusiness.h"

@interface RTUserProfileViewController : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    NSArray *genderArray;
}


@property (strong, nonatomic) IBOutlet UIButton *next;
- (IBAction)nextStep:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *step1View;


@property (strong, nonatomic) IBOutlet UIView *step2View;


@property (strong, nonatomic) IBOutlet UIView *step3View;

@property (strong, nonatomic) IBOutlet UIView *settingInfoView;



@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *stepIndicatorView;
@property (strong, nonatomic) IBOutlet UIImageView *stepIndicatorImage;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *step2IndicatorTextLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *step1IndicatorTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *DoneBtn;
- (IBAction)DoneAction:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *step3IndicatorTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *formerStepBtn;
- (IBAction)formerStep:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *dataPicker;



@property (strong, nonatomic) IBOutlet UITextField *birthdayInputTextField;





-(IBAction)dataChanged:(id)sender;
-(IBAction)doneDateEditing:(id)sender;
@property (strong, nonatomic) IBOutlet UIToolbar *accessoryViewForDateInput;

@property (strong, nonatomic) IBOutlet UITextField *genderInputField;

@property (strong, nonatomic) IBOutlet UITextField *weightInputField;
@property (strong, nonatomic) IBOutlet UITextField *heightInputField;


-(BOOL)saveOnAVOSCloud;

@property (strong, nonatomic) IBOutlet UIPickerView *genderPicker;




@end
