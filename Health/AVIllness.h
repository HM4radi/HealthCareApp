//
//  AVIllness.h
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

#import <Foundation/Foundation.h>

@interface AVIllness : AVObject <AVSubclassing>

@property (nonatomic,copy) NSString *symptom;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *inject;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *room;
@property (nonatomic,copy) NSString *check_method;
@property (nonatomic,copy) NSString *reason;
@property (nonatomic,copy) NSString *check_result;


@property (nonatomic,strong)NSString *info;





@end
