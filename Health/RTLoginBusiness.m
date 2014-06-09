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
    self.isSucceed=[AVUser logInWithUsername:username password:pwd error:&error];
    if (self.isSucceed!=nil && self.isSucceed) {
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
      
    }
    else
    {
    
        self.feedback=@"登录失败，";
      
    
    }
    return result;
}
@end
