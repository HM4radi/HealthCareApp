//
//  RTPlanData.m
//  Health
//
//  Created by GeoBeans on 14-6-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTPlanData.h"

@implementation RTPlanData
@synthesize startTime;
@synthesize lastTime;
@synthesize sportType;
@synthesize colories;
@synthesize location;


+ (RTPlanData*)shareInstance{
    
    static RTPlanData* planData=nil;
    
    @synchronized(self)
    {
        if (!planData){
            planData = [[RTPlanData alloc] init];
        }
        return planData;
    }
}


@end
