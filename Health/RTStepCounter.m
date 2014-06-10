//
//  RTStepCounter.m
//  Health
//
//  Created by GeoBeans on 14-6-10.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTStepCounter.h"

@implementation RTStepCounter
@synthesize step;
@synthesize status;
@synthesize speed;

+ (RTStepCounter*)sharedRTSterCounter{
    
    static RTStepCounter* sharedRTSterCounter=nil;
    
    @synchronized(self)
    {
        if (!sharedRTSterCounter){
            sharedRTSterCounter = [[RTStepCounter alloc] init];
        }
        return sharedRTSterCounter;
    }
}

- (void)startCounting{
    if (!([CMStepCounter isStepCountingAvailable] || [CMMotionActivityManager isActivityAvailable])) {
        
        NSString *msg = @"对不起哦，计步功能暂时只支持iPhone5s哦，快点跟换新设备吧~";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opps!!!"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    //更新label
    if ([CMStepCounter isStepCountingAvailable]) {
        
        self.stepCounter = [[CMStepCounter alloc] init];
        
        [self.stepCounter startStepCountingUpdatesToQueue:self.operationQueue
                                                 updateOn:1
                                              withHandler:
         ^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 if (error) {
                     UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Opps!" message:@"error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [error show];
                 }
                 else {
                     self.step = [NSString stringWithFormat:@"%ld", (long)numberOfSteps];
                 }
             });
         }];
    }
    
    //開波
    if ([CMMotionActivityManager isActivityAvailable]) {
        
        self.activityManager = [[CMMotionActivityManager alloc] init];
        
        [self.activityManager startActivityUpdatesToQueue:self.operationQueue
                                              withHandler:
         ^(CMMotionActivity *activity) {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 self.status = [self statusForActivity:activity];
                 self.speed = [self stringFromConfidence:activity.confidence];
             });
         }];
    }
}

- (NSString *)statusForActivity:(CMMotionActivity *)activity {
    
    NSMutableString *sta = @"".mutableCopy;
    
    if (activity.stationary) {
        
        [sta appendString:@"not moving"];
    }
    
    if (activity.walking) {
        
        if (sta.length) [sta appendString:@", "];
        
        [sta appendString:@"on a walking person"];
    }
    
    if (activity.running) {
        
        if (sta.length) [sta appendString:@", "];
        
        [sta appendString:@"on a running person"];
    }
    
    if (activity.automotive) {
        
        if (sta.length) [sta appendString:@", "];
        
        [sta appendString:@"in a vehicle"];
    }
    
    if (activity.unknown || !sta.length) {
        
        [sta appendString:@"unknown"];
    }
    
    return sta;
}
- (NSString *)stringFromConfidence:(CMMotionActivityConfidence)confidence {
    
    switch (confidence) {
            
        case CMMotionActivityConfidenceLow:
            
            return @"Low";
            
        case CMMotionActivityConfidenceMedium:
            
            return @"Medium";
            
        case CMMotionActivityConfidenceHigh:
            
            return @"High";
            
        default:
            
            return nil;
    }
}

@end
