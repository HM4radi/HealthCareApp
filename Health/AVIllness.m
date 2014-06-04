//
//  AVIllness.m
//  Health
//
//  Created by Mac on 6/4/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import "AVIllness.h"

@implementation AVIllness

@dynamic name;
@dynamic check_method;
@dynamic check_result;
@dynamic desc;
@dynamic room;
@dynamic inject;
@dynamic reason;
@dynamic symptom;


+ (NSString *)parseClassName {
    
    return @"illnesses";
}


@end
