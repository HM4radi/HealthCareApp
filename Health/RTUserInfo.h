//
//  RTUserInfo.h
//  Health
//
//  Created by GeoBeans on 14-6-8.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface RTUserInfo : AVObject <AVSubclassing>

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *userAge;
@property  BOOL userGender;
@property float userHeight;
@property float userWeight;
@property (nonatomic,copy) AVFile *userImage;
@end
