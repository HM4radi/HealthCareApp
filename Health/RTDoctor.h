//
//  RTDoctor.h
//  Health
//
//  Created by Mac on 5/27/14.
//  Copyright (c) 2014 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTDoctor : NSObject{
//    NSString *name;
//    NSString *category;
//    NSString *rank;
//    NSString *businessArea;
//    NSString *otherInfo;
    
}
@property (nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *category;
//@property(nonatomic,strong)NSString *rank;
//@property(nonatomic,strong)NSString *businessArea;
@property(nonatomic,strong)NSString *info;

+(id)doctorOfCategory:(NSString*)category name:(NSString*)name;
@end
