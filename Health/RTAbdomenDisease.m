//
//  RTAbdomenDisease.m
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTAbdomenDisease.h"

@implementation RTAbdomenDisease
+(id)abdomenDiseaseOfCategory:(NSString*)info name:(NSString*)name
{
    RTAbdomenDisease *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
    
    
}
@end
