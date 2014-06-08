//
//  RTUser.h
//  Health
//
//  Created by Mac on 6/5/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface RTUser : NSObject

{
}
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *pwd;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *height;
@property (nonatomic,strong)NSString *weight;
@property (nonatomic,strong)NSString *healthIndex;
@property (nonatomic,strong)NSString *BMI;
@property (nonatomic,strong)NSString *userChannelNews;
@property (nonatomic,strong)NSString *userImage;
@property (nonatomic,strong)NSString *gender;
@property (nonatomic,strong)NSString *age;
@property (nonatomic,strong)NSString *salt;
@property (nonatomic,strong)NSString *familyMemberObjectId;






-(id)calculateBMI;
@end
