//
//  RTPlanData.h
//  Health
//
//  Created by GeoBeans on 14-6-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPlanData : NSObject
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *lastTime;
@property (nonatomic,strong) NSString *sportType;
@property (nonatomic) float colories;
@property (nonatomic,strong) NSString *location;

+ (RTPlanData*)shareInstance;
@end
