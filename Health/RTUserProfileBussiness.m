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
   
    //可以继续添加
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    
    
    return YES;
}

-(id)queryUserProfile{
    
    return nil;
}
@end
