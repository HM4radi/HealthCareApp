//
//  RTDoctor.m
//  Health
//
//  Created by Mac on 5/27/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "RTDoctor.h"

@implementation RTDoctor
+(id)doctorOfCategory:(NSString *)category name:(NSString *)name
{
    RTDoctor *newDoctor=[[self alloc] init];
    newDoctor.category=category;
    newDoctor.info=category;
    newDoctor.name=name;
    return newDoctor;
    
}

@end
