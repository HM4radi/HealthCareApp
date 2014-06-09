//
//  RTLoginBusiness.m
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//



//NSUserDefault  对应key-value 说明

//CurrentUserName                   --  username             of  RTUserInfo
//CurrentUserAge                    --  userAge              of  RTUserInfo
//CurrentUserGender                 --  userGenderName       of  RTUserInfo
//CurrentUserProtaitImageName       --  userImageName        of  RTUserInfo
//CurrentUserHeight                 --  height               of  RTUserInfo
//CurrentUserWeight                 --  weight               of  RTUserInfo
//CurrentUserBMI                    --  BMI                  of  RTUserInfo
//CurrentUserPhone                  --  phone                of  RTUserInfo
//CurrentUserEmail                  --  email                of  RTUserInfo
//CurrentUserSalt                   --  salt                 of  RTUserInfo
//CurrentUserNewsChannel            --  userChannelNews      of  RTUserInfo
//CurrentUserHealthIndex            --  CurrentUserHealthIndex   of  RTUserInfo
//
//auto_login                        --  (BOOL)               是否自动登录

//CurrentUserProfileIsSetted        --  (NSString) Has Been Setted  是否填写用户信息

#import "RTLoginBusiness.h"

@implementation RTLoginBusiness

-(void)loginInbackground:(NSString *)username Pwd:(NSString *)pwd
{
    [AVUser logInWithUsernameInBackground:username password:pwd block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self loginIsSucceed:YES];
            
            
        }
        else {
            [self loginIsSucceed:NO];
            self.feedback=[self.feedback stringByAppendingString:[error localizedDescription]];

        }
        
    }];


}

-(void)login:(NSString *)username Pwd:(NSString *)pwd
{
    NSError *error;
    AVUser *loginUser=[AVUser logInWithUsername:username password:pwd error:&error];
    if (loginUser!=nil) {
        [self loginIsSucceed:YES];
        [self saveUserBasicInfoLocally:username Pwd:pwd];
        
    }
    else {
        [self loginIsSucceed:NO];
        self.feedback=[self.feedback stringByAppendingString:[error localizedDescription]];
        
    }

    
    
 

}

-(BOOL)loginIsSucceed:(BOOL)result
{
    
    if (result) {
        self.feedback=@"登录成功";
        self.isSucceed=YES;
      
    }
    else
    {
    
        self.feedback=@"登录失败，";
        self.isSucceed=NO;
    
    }
    return result;
}



-(BOOL)saveUserBasicInfoLocally:(NSString*) username
{
    
    //save username
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    [mySettingData setObject:username forKey:@"CurrentUserName"];
    //注意此处是明文存储，可能会带来安全性问题

    //
    [mySettingData setValue:@YES forKey:@"auto_login"];
    return YES;
}


-(BOOL)saveUserBasicInfoLocally:(NSString*) username Pwd:(NSString*) pwd
{
    //save username
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    [mySettingData setObject:username forKey:@"CurrentUserName"];
    //注意此处是明文存储，可能会带来安全性问题
    
    [mySettingData setObject:pwd forKey:@"CurrentUserPassword"];
        
        
        [mySettingData setBool:YES  forKey:@"auto_login"];
    
    
    return YES;

}


-(BOOL)saveUserInfoLocally:(id)userProfilwInfo
{
    
    //设置NSUserdefault
    RTUserInfo *userinfo=userProfilwInfo;
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    if (userinfo.username!=nil) {
        [mySettingData setObject:userinfo.username forKey:@"CurrentUserName"];
    }
    if (userinfo.userAge!=nil) {
         [mySettingData setObject:userinfo.userAge forKey:@"CurrentUserAge"];
    }
    if (userinfo.userGenderName!=nil) {
            [mySettingData setObject:userinfo.userGenderName forKey:@"CurrentUserGender"];
    }
    if (userinfo.userImageName) {
            [mySettingData setObject:userinfo.userImageName forKey:@"CurrentUserProtaitImageName"];
    }
    if (userinfo.height!=nil) {
        [mySettingData setObject:userinfo.height forKey:@"CurrentUserHeight"];
    }
    if (userinfo.weight!=nil) {
         [mySettingData setObject:userinfo.weight forKey:@"CurrentUserWeight"];
    }
    if (userinfo.BMI!=nil) {
         [mySettingData setObject:userinfo.BMI forKey:@"CurrentUserBMI"];
    }
    if (userinfo.phone!=nil) {
        [mySettingData setObject:userinfo.phone forKey:@"CurrentUserPhone"];
    }
    if (userinfo.email!=nil) {
         [mySettingData setObject:userinfo.email forKey:@"CurrentUserEmail"];
    }
    if (userinfo.salt!=nil) {
        [mySettingData setObject:userinfo.salt forKey:@"CurrentUserSalt"];
    }
   
    if (userinfo.userChannelNews!=nil) {
         [mySettingData setObject:userinfo.userChannelNews forKey:@"CurrentUserNewsChannel"];
    }
    if (userinfo.healthIndex!=nil) {
            [mySettingData setObject:userinfo.healthIndex forKey:@"CurrentUserHealthIndex"];
    }
   
    [mySettingData synchronize];  
    


    return YES;
}
-(BOOL)checkIfAuto_login
{
    AVUser *cuser=[AVUser currentUser];
    if(cuser!=nil)
    {
    
        [self saveUserBasicInfoLocally:cuser.username];
        return YES;
    }
    else
    {
     return NO;
    }

}


@end
