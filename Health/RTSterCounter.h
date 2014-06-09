//
//  RTSterCounter.h
//  Health
//
//  Created by GeoBeans on 14-6-9.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface RTSterCounter : NSObject
@property (nonatomic,strong) NSString *step;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *speed;

@property (nonatomic, strong) CMStepCounter *stepCounter;
@property (nonatomic, strong) CMMotionActivityManager *activityManager;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

+ (RTSterCounter*)sharedRTSterCounter;
- (void)startCounting;
@end
