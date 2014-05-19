//
//  RTShareMsg.h
//  Health
//
//  Created by GeoBeans on 14-5-18.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"


@interface RTShareMsg : NSObject<UIApplicationDelegate,WXApiDelegate,UIAlertViewDelegate>{
    
    enum WXScene _scene;

}

- (void) sendTextContent;
@end
