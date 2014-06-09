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
//
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *userAge;
@property (nonatomic,strong)NSString *pwd;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *email;
//
@property (nonatomic,strong)NSString *userGenderName;
@property  BOOL userGender;

//
@property float userHeight;
@property float userWeight;
@property (nonatomic,strong)NSString *height;
@property (nonatomic,strong)NSString *weight;

//
@property (nonatomic,copy) AVFile *userImage;
@property (nonatomic,strong)NSString *userImageName;


//
@property (nonatomic,strong)NSString *healthIndex;
@property (nonatomic,strong)NSString *BMI;


//
@property (nonatomic,strong)NSString *userChannelNews;
@property (nonatomic,strong)NSString *salt;
@property (nonatomic,strong)NSString *familyMemberObjectId;




@end
