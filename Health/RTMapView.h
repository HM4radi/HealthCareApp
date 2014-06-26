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
#import "RTPlanData.h"
#import "RTSportRecord.h"
@interface RTMapView : UIView<QAppKeyCheckDelegate,QMapViewDelegate,UIGestureRecognizerDelegate,QReverseGeocoderDelegate>
{
    IBOutlet QMapView* _mapView;
    NSMutableArray *route;
    NSMutableArray *routeCoord;
    QReverseGeocoder* _reverseGeocoder;
    RTPlanData *planData;
    RTSportRecord *sportRecord;
}

@property(nonatomic, retain) QAppKeyCheck* appKeyCheck;
@property(nonatomic, retain)IBOutlet QMapView* mapView;
@property(nonatomic, retain) NSMutableArray *routeCoord;
@property(nonatomic)BOOL selecting;
@property(nonatomic, retain) QReverseGeocoder* reverseGeocoder;
@property(nonatomic)BOOL recording;
@property(nonatomic, retain) UIColor *lineColor;
- (void)addPointAnno:(QPointAnnotation*) pointAnno;
- (void)removePointAnno:(QPointAnnotation*) pointAnno;
- (void)addPolyline:(CLLocationCoordinate2D[])polylineArray withcount:(int)count;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point;
- (void)setSelecting:(BOOL)selecting;
- (void)removeLastPoint;
-(void)returnPlaceName:(NSString*)pt;
- (CLLocationCoordinate2D*)convertToCoord2D:(NSArray*)data;
- (void)setCenterCoord:(CLLocationCoordinate2D)coord;
- (void)showLocation;
- (NSDictionary*)returnLocationInfo;
@end
