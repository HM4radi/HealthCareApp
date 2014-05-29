//
//  RTHandDisease.m
//  Health
//
//  Created by Mac on 5/28/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTHandDisease.h"

@implementation RTHandDisease
+(id)handDiseaseOfCategory:(NSString*)info name:(NSString*)name
{
    RTHandDisease *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
    
    
}
@end
