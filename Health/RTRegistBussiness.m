//
//  RTRegistBussiness.m
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTRegistBussiness.h"

@implementation RTRegistBussiness

-(void)NewUserRegistInBackground:(NSString*)username Pwd:(NSString*)password Email:(NSString *)email Phone:(NSString *)phone{
    
    AVUser * user = [AVUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    [user setObject:phone forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
           [self RegistHasSucceed];
        } else {
           [self RegistHasFailed];
            self.feedback=[self.feedback stringByAppendingString:[error localizedDescription]];
            NSLog(@"feedback:%@",self.feedback);
            
        }

    }];
    
   
}


-(BOOL)NewUserRegist:(NSString*)username Pwd:(NSString*)password Email:(NSString*)email Phone:(NSString*) phone{
    static BOOL isSuccess=NO;
    NSError  *error;

    AVUser * user = [AVUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    [user setObject:phone forKey:@"phone"];
    isSuccess=[user signUp:&error];
    if (!isSuccess) {
        [self RegistHasFailed];
        self.feedback=[self.feedback stringByAppendingString:[error localizedDescription]];
        NSLog(@"feedback:%@",self.feedback);
        NSLog(@"errorLog:%@",[error localizedDescription]);
        
    }
    else{
        [self RegistHasSucceed];
    }
    return isSuccess;


}

-(void) RegistHasFailed
{
   self.feedback=@"注册失败,";
    
    

}
-(void) RegistHasSucceed
{
    self.feedback=@"注册成功";
    
}

@end
