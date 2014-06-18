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
@synthesize calories;
@synthesize sportGeoPointDescription;
@synthesize progress;



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

- (id)init{
    if(self = [super init]){      
        sportGeoPointDescription=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)resetting{
    self.startTime=nil;
    self.lastTime=nil;
    self.endTime=nil;
    self.sportType=nil;
    self.calories=nil;
    self.strength=nil;
    [self.sportGeoPointDescription removeAllObjects];
}


@end
