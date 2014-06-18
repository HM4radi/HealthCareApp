//
//  RTRegisterViewController.m
//  Health
//
//  Created by GeoBeans on 14-5-19.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTRegisterViewController.h"
#import "RTRegistBussiness.h"



@interface RTRegisterViewController ()


@end

@implementation RTRegisterViewController

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
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:loginNumber];
    
    Register=[[RTRegistBussiness alloc]init];
    self.nextBtn.enabled=NO;
    self.finishRegistBtn.enabled=NO;
    
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)next:(id)sender {
    if (loginNumber.superview==self.view) {
        [loginNumber removeFromSuperview];
        [self.view addSubview:loginPass];
    }else
    {
        [self startRegister];
    }

}

- (void)startRegister
{
    
    //add register code
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doRegist:(id)sender {
   
    BOOL isRegistedSeccuss=[Register NewUserRegist:Register.username Pwd:Register.pwd Email:Register.email Phone:Register.phone];
    if (isRegistedSeccuss) {
        self.finishRegistBtn.enabled=YES;
        self.registFeedBack.text=@"恭喜你，注册成功！";
        self.registFeedBack.textColor=[UIColor blueColor];
    }
    else
    {
        self.finishRegistBtn.enabled=NO;
        self.registFeedBack.text=Register.feedback;
        self.registFeedBack.textColor=[UIColor redColor];
    }
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    
    //在此处可以限制字长
    
//    if (textField==self.phoneInputField) {
//        Register.username=[textField.text stringByReplacingCharactersInRange:range withString:string];
//    }
//    if (textField==self.passwordInputField) {
//        Register.pwd=[textField.text stringByReplacingCharactersInRange:range withString:string];
//    }
//    
    return YES;
    
}

- (IBAction)checkPhoneNumber:(id)sender {
    
    Register.phone=self.phoneInputField.text;
  
    if(Register.phone.length!=11)
    {
        self.phoneInputTextBorderView.backgroundColor=[UIColor redColor];
        self.infoLabel.text=@"请输入正确的手机号";
        self.infoLabel.textColor=[UIColor redColor];
    }
    else
    {
        self.infoLabel.text=@"正确，请下一步！";
        self.phoneInputTextBorderView.backgroundColor=[UIColor blueColor];
         self.infoLabel.textColor=[UIColor blueColor];
        self.nextBtn.enabled=YES;
    }
}

- (IBAction)done:(id)sender {
    if (loginNumber.superview==self.view) {
    [loginNumber removeFromSuperview];
    [self.view addSubview:loginPass];
    }
}

- (IBAction)checkEmail:(id)sender {
    NSString *email=self.emailInputField.text;
    
    if ([self isValidateEmail:email]) {
        
        Register.email=email;
        self.emailInputFieldBorder.backgroundColor=[UIColor blueColor];
        self.emailCheckInfo.text=nil;
    }
    else
    {
      self.emailCheckInfo.text=@"请输入正确的邮箱";
        self.emailCheckInfo.textColor=[UIColor redColor];
        self.emailInputFieldBorder.backgroundColor=[UIColor redColor];
    }
    
    
    
}

- (IBAction)checkPassword:(id)sender {
    NSString *pwd1=self.passwordInputField.text;
    NSString *pwd2=self.pwdAgainInputTextField.text;
    if (pwd1.length<6) {
        self.pwdCheckInfo.textColor=[UIColor redColor];
        self.pwdCheckInfo.text=@"请输入6位以上密码";
        self.pwdInputFieldBorderView.backgroundColor=[UIColor redColor];
        self.pwdAgainInputFieldBorder.backgroundColor=[UIColor redColor];
    }
    else
    {
        if(![pwd1 isEqualToString:pwd2]){
            self.pwdInputFieldBorderView.backgroundColor=[UIColor redColor];
            self.pwdCheckInfo.text=@"两次输入密码不等";
            self.pwdInputFieldBorderView.backgroundColor=[UIColor redColor];
            self.pwdAgainInputFieldBorder.backgroundColor=[UIColor redColor];
        }
        else
        {
            Register.pwd=pwd1;
            self.pwdInputFieldBorderView.backgroundColor=[UIColor blueColor];
            self.pwdCheckInfo.text=nil;
            self.pwdAgainInputFieldBorder.backgroundColor=[UIColor blueColor];
        }
   
    
    }
    
}

- (IBAction)checkUsername:(id)sender {
    NSString *username=self.usernameInputField.text;
    
    if (username.length==0 || [username hasPrefix:@" "]) {
        self.usernameCheckInfo.textColor=[UIColor redColor];
        self.usernameCheckInfo.text=@"用户命不能为空";
        self.usernameInputFieldBorder.backgroundColor=[UIColor redColor];
    }
    else{
     Register.username=username;
        self.usernameCheckInfo.text=nil;
         self.usernameInputFieldBorder.backgroundColor=[UIColor blueColor];
    
    }
   
    
}
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (IBAction)upLoadImagesAction:(id)sender {
    
     
}
@end
