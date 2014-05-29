//
//  RTLegDisease.m
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTLegDisease.h"

@implementation RTLegDisease
+(id)legDiseaseOfCategory:(NSString*)info name:(NSString*)name
{
    RTLegDisease *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
    
    
}
@end
