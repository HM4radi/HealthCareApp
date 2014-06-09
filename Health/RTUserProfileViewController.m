//
//  RTUserProfileViewController.m
//  Health
//
//  Created by Mac on 6/5/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTUserProfileViewController.h"
#import "RTMainViewController.h"

@interface RTUserProfileViewController ()
{
    int stepCountflag;
}
@end

@implementation RTUserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    genderArray=[[NSArray alloc]initWithObjects:@"男",@"女",nil];
    // Do any additional setup after loading the view from its nib.
    self.formerStepBtn.hidden=YES;
    self.formerStepBtn.enabled=NO;
    
    self.DoneBtn.hidden=YES;
    self.DoneBtn.enabled=NO;
    
    stepCountflag=0;
    [self.settingInfoView addSubview:self.step1View];
    
    self.birthdayInputTextField.inputView=self.dataPicker;
    self.birthdayInputTextField.inputAccessoryView=self.accessoryViewForDateInput;
    
    self.genderInputField.inputView=self.genderPicker;
    self.genderInputField.inputAccessoryView=self.accessoryViewForDateInput;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextStep:(id)sender {
    
    //step2 to step3
    if (stepCountflag==1) {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        //     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        
        
        //     [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        [self.step2View removeFromSuperview];
        [self.settingInfoView addSubview:self.step3View];
        self.stepIndicatorImage.image=[UIImage imageNamed:@"3(1).png"];
        for (UILabel *label in self.step3IndicatorTextLabel) {
            label.textColor=[UIColor colorWithRed:0.5f green:0.75f blue:0.17f alpha:1.0f];
        }
        [UIView commitAnimations];
        stepCountflag=2;
        
        self.next.hidden=YES;
        self.next.enabled=NO;
        self.DoneBtn.hidden=NO;
        self.DoneBtn.enabled=YES;
        
        

    }
    
    //step1 to step2
    if (stepCountflag==0) {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        //     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        
        
        //     [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        [self.step1View removeFromSuperview];
        [self.settingInfoView addSubview:self.step2View];
        self.stepIndicatorImage.image=[UIImage imageNamed:@"2(1).png"];
        for (UILabel *label in self.step2IndicatorTextLabel) {
            label.textColor=[UIColor colorWithRed:0.5f green:0.75f blue:0.17f alpha:1.0f];
        }
        [UIView commitAnimations];
        stepCountflag=1;
        self.formerStepBtn.hidden=NO;
        self.formerStepBtn.enabled=YES;
        self.cancelBtn.hidden=YES;
        self.cancelBtn.enabled=NO;
        
    }
    
   
   
}

- (IBAction)formerStep:(id)sender {
    
    
    //step2 backto step1
    if (stepCountflag==1) {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        //     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        
        
        //     [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        [self.step2View removeFromSuperview];
        [self.settingInfoView addSubview:self.step1View];
        self.stepIndicatorImage.image=[UIImage imageNamed:@"1(1).png"];
        for (UILabel *label in self.step2IndicatorTextLabel) {
            label.textColor=[UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.0f];
        }
        [UIView commitAnimations];
        stepCountflag=0;
        self.formerStepBtn.hidden=YES;
        self.formerStepBtn.enabled=NO;
        self.cancelBtn.hidden=NO;
        self.cancelBtn.enabled=YES;
    }
    
    
    //step3 backto step1
    if (stepCountflag==2) {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        //     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        
        
        //     [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromRight forView:self.settingInfoView cache:YES];
        [self.step3View removeFromSuperview];
        [self.settingInfoView addSubview:self.step2View];
        self.stepIndicatorImage.image=[UIImage imageNamed:@"2(1).png"];
        for (UILabel *label in self.step3IndicatorTextLabel) {
            label.textColor=[UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.0f];
        }
        [UIView commitAnimations];
        stepCountflag=1;
        
        self.DoneBtn.hidden=YES;
        self.DoneBtn.enabled=NO;
        self.next.hidden=NO;
        self.next.enabled=YES;
        
    }
    
    
}
- (IBAction)DoneAction:(id)sender {
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    [mySettingData setObject:@"Has Been Setted"  forKey:@"CurrentUserProfileIsSetted"];
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(id)sender {
    UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"设置未完成，确定要返回？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"继续设置", nil];
    [alerView show];
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (buttonIndex==1) {
        
    }
    
    
}


-(IBAction)dataChanged:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *date = [dateFormatter stringFromDate:picker.date];
    self.birthdayInputTextField.text =date;


}

-(IBAction)doneDateEditing:(id)sender
{
    if ([self.birthdayInputTextField isFirstResponder]) {
        [self.birthdayInputTextField resignFirstResponder];
    }
    if ([self.genderInputField isFirstResponder]) {
        [self.genderInputField resignFirstResponder];
    }

}



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
  [textField resignFirstResponder];
    return YES;
}



-(BOOL)saveOnAVOSCloud
{

    return YES;
}

#pragma -mark  UIPickView delegate method for genderInputField.inputView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [genderArray count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    return [genderArray objectAtIndex:row];
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSString *selectedGender=[genderArray objectAtIndex:row];
    self.genderInputField.text=selectedGender;
}
@end
