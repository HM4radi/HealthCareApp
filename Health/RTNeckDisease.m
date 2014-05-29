//
//  RTNeckDisease.m
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTNeckDisease.h"

@implementation RTNeckDisease
@synthesize name;
@synthesize info;
+(id)diseaseNewDisease:(NSString *)info name:(NSString *)name
{
    RTNeckDisease *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
  

}

@end
