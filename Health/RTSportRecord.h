//
//  RTSportRecord.h
//  Health
//
//  Created by GeoBeans on 14-6-25.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTSportRecord : NSObject
{
    NSMutableArray *realCoordinate;
    NSMutableArray *realTime;
    NSMutableArray *realCalories;
    NSMutableArray *realSpeed;

}

@property (nonatomic, strong) NSMutableArray *realCoordinate;
@property (nonatomic, strong) NSMutableArray *realTime;
@property (nonatomic, strong) NSMutableArray *realCalories;
@property (nonatomic, strong) NSMutableArray *realSpeed;
@property (nonatomic) float nowSpeed;
@property (nonatomic) float nowCalories;
@property (nonatomic) float nowDistance;
+ (RTSportRecord*)shareInstance;
- (void)resetData;
@end
