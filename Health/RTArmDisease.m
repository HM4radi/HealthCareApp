//
//  RTArmDisease.m
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTArmDisease.h"

@implementation RTArmDisease
+(id)armDiseaseOfCategory:(NSString*)info name:(NSString*)name
{
    RTArmDisease *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
    
    
}
@end
