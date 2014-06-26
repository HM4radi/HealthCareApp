//
//  RTSportRecord.m
//  Health
//
//  Created by GeoBeans on 14-6-25.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTSportRecord.h"

@implementation RTSportRecord
@synthesize realCoordinate;
@synthesize realCalories;
@synthesize realTime;
@synthesize realSpeed;
@synthesize nowCalories;
@synthesize nowDistance;
@synthesize nowSpeed;

+ (RTSportRecord*)shareInstance{
    
    static RTSportRecord* sportRecord=nil;
    
    @synchronized(self)
    {
        if (!sportRecord){
            sportRecord = [[RTSportRecord alloc] init];
        }
        return sportRecord;
    }
}

- (id)init{
    if(self = [super init]){
        realCoordinate=[[NSMutableArray alloc]init];
        realTime=[[NSMutableArray alloc]init];
        realCalories=[[NSMutableArray alloc]init];
        realSpeed=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)resetData{
    self.nowSpeed=0;
    self.nowDistance=0;
    self.nowCalories=0;
    [realCoordinate removeAllObjects];
    [realTime removeAllObjects];
    [realCalories removeAllObjects];
    [realSpeed removeAllObjects];
}
@end
