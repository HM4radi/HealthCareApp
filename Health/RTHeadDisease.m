//
//  RTHeadDisease.m
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTHeadDisease.h"

@implementation RTHeadDisease
+(id)headDiseaseOfCategory:(NSString*)info name:(NSString*)name
{
    RTHeadDisease *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
    

}
@end
