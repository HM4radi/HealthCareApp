//
//  RTPlanData.h
//  Health
//
//  Created by GeoBeans on 14-6-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPlanData : NSObject
{
    NSMutableArray *sportGeoPointDescription;
}
@property (nonatomic,strong) NSDate *startTime;
@property (nonatomic,strong) NSDate *lastTime;
@property (nonatomic,strong) NSDate *endTime;
@property (nonatomic,strong) NSString *sportType;
@property (nonatomic,strong) NSNumber *calories;
@property (nonatomic,strong) NSString *strength;
@property (nonatomic)BOOL querySuccess;
@property (nonatomic, strong) NSMutableArray *sportGeoPointDescription;
@property (nonatomic,strong) NSArray *routeCoord;
@property (nonatomic,strong) NSNumber *progress;
@property (nonatomic,strong) NSString *objectId;
+ (RTPlanData*)shareInstance;
- (void)resetting;
@end
