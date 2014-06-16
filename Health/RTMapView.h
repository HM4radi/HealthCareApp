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

@interface RTMapView : UIView<QAppKeyCheckDelegate,QMapViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet QMapView* _mapView;
    NSMutableArray *route;
    NSMutableArray *routeCoord;
}

@property(nonatomic, retain) QAppKeyCheck* appKeyCheck;
@property(nonatomic, retain)IBOutlet QMapView* mapView;
@property (nonatomic, retain) NSMutableArray *routeCoord;
@property (nonatomic)BOOL selecting;
- (void)addPointAnno:(QPointAnnotation*) pointAnno;
- (void)removePointAnno:(QPointAnnotation*) pointAnno;
- (void)addPolyline:(CLLocationCoordinate2D[])polylineArray withcount:(int)count;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point;
- (void)setSelecting:(BOOL)selecting;
- (void)removeLastPoint;
@end
