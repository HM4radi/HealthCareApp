//
//  RTUserProfileBussiness.m
//  Health
//
//  Created by Mac on 6/5/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTUserProfileBussiness.h"

@implementation RTUserProfileBussiness


-(BOOL)loadUserProfile
{
    self.user=[AVUser currentUser];
    [self.user setObject:self.rtUser.age forKey:@"userAge"];
    [self.user setObject:self.rtUser.gender forKey:@"userGender"];
    [self.user setObject:self.rtUser.height forKey:@"userHeight"];
    [self.user setObject:self.rtUser.weight forKey:@"userWeight"];
    [self.user setObject:self.rtUser.userChannelNews forKey:@"userChannelNews"];
    [self.user setObject:self.rtUser.salt forKey:@"salt"];
    //可以继续添加
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    
    
    return YES;
}
@end
