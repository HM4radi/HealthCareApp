//
//  RTUserInfo.m
//  Health
//
//  Created by GeoBeans on 14-6-8.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTUserInfo.h"

@implementation RTUserInfo

@dynamic username;
@dynamic userAge;
@dynamic userGender;
@dynamic userHeight;
@dynamic userWeight;
@dynamic userImage;


+ (NSString *)parseClassName {
    return @"_User";
}

@end
