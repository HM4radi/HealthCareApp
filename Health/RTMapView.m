//
//  RTMapView.m
//  Health
//
//  Created by GeoBeans on 14-5-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTMapView.h"

@implementation RTMapView
@synthesize mapView = _mapView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self KeyCheck];
        _mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_mapView];
        
    }
    return self;
}

- (void)KeyCheck{
    
    QAppKeyCheck* check = [[QAppKeyCheck alloc] init];
    [check start:@"536a2a3ece4b0a8cb812e59e6" withDelegate:self];
    self.appKeyCheck = check;
    //[check release];

}

- (void)notifyAppKeyCheckResult:(QErrorCode)errCode
{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
