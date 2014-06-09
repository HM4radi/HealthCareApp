//
//  RTUserProfileBussiness.h
//  Health
//
//  Created by Mac on 6/5/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface RTUserProfileBussiness : NSObject

@property (strong,nonatomic)AVUser *user;


-(BOOL)loadUserProfile;
-(id)queryUserProfile;


@end
