//
//  RTUserProfileBussiness.h
//  Health
//
//  Created by Mac on 6/5/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "RTUser.h"
@interface RTUserProfileBussiness : NSObject

@property (strong,nonatomic)AVUser *user;
@property (nonatomic,strong)RTUser *rtUser;

-(BOOL)loadUserProfile;
-(id)queryUserProfile;

@end
