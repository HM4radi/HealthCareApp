//
//  RTMapView.h
//  Health
//
//  Created by GeoBeans on 14-5-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"
#import "QAppKeyCheck.h"

@interface RTMapView : UIView<QAppKeyCheckDelegate,QMapViewDelegate>
{
    IBOutlet QMapView* _mapView;
    NSMutableArray *route;
    
}

@property(nonatomic, retain) QAppKeyCheck* appKeyCheck;
@property(nonatomic, retain)IBOutlet QMapView* mapView;
- (void)addPointAnno:(QPointAnnotation*) pointAnno;
- (void)removePointAnno:(QPointAnnotation*) pointAnno;
- (void)addPolyline:(CLLocationCoordinate2D[])polylineArray withcount:(int)count;
@end
