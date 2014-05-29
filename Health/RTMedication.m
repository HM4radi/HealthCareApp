//
//  RTMedication.m
//  Health
//
//  Created by Mac on 5/29/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTMedication.h"

@implementation RTMedication 
@synthesize name;
@synthesize info;
+(id)diseaseNewDisease:(NSString *)info name:(NSString *)name
{
    RTMedication *newDisease=[[self alloc] init];
    newDisease.info=info;
    newDisease.name=name;
    return newDisease;
    
    
}
@end
