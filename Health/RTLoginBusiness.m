//
//  RTLoginBusiness.m
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

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
@end
