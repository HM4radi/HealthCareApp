//
//  RTMapView.m
//  Health
//
//  Created by GeoBeans on 14-5-15.
//  Copyright (c) 2014年 RADI Team. All rights reserved.
//

#import "RTMapView.h"
#import <mach/mach_time.h>

@implementation RTMapView
@synthesize mapView = _mapView;
@synthesize selecting=_selecting;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self KeyCheck];
        _mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_mapView];
        _mapView.userInteractionEnabled=YES;
        _mapView.delegate = self;
        route=[[NSMutableArray alloc]init];
        //[_mapView setShowsUserLocation:YES];
        self.selecting=NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        if (![tapGesture respondsToSelector:@selector(locationInView:)]) {
            [tapGesture release];
            tapGesture = nil;
        }else {
            tapGesture.delegate = self;
            tapGesture.numberOfTapsRequired = 1; // The default value is 1.
            tapGesture.numberOfTouchesRequired = 1; // The default value is 1.
            [_mapView addGestureRecognizer:tapGesture];
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (self.selecting) {
        CGPoint pt=[touch locationInView:[touch view]];
        QPointAnnotation* annotation = [[QPointAnnotation alloc]init];
        CLLocationCoordinate2D p=[_mapView convertPoint:pt toCoordinateFromView:[touch view]];
        [annotation setCoordinate:p];
        NSString *coordinate=NSStringFromCGPoint(CGPointMake(p.longitude, p.latitude));
        [route addObject:coordinate];
        [_mapView addAnnotation:annotation];
    }
    return YES;
}

- (void)setSelecting:(BOOL)selecting{
    
    _selecting=selecting;
    
    if (_selecting){
        [route removeAllObjects];
    }
}

/**************************KeyCheck****************************/
- (void)KeyCheck{
    QAppKeyCheck* check = [[QAppKeyCheck alloc] init];
    [check start:@"JIEBZ-CM2WQ-HX75D-GCMMT-RM5IZ-2DB7E" withDelegate:self];
    self.appKeyCheck = check;
    [check release];
}

- (void)notifyAppKeyCheckResult:(QErrorCode)errCode
{
    
    if (errCode == QErrorNone) {
        NSLog(@"恭喜您，APPKey验证通过！");
    }
    else if(errCode == QNetError)
    {
        NSLog(@"网络好像不太给力耶！请检查下网络是否畅通?！");
    }
    else if(errCode == QAppKeyCheckFail)
    {
        NSLog(@"您的APPKEY好像是有问题喔，请检查下APPKEY是否正确？");
    }
}

/**************************定位功能****************************/
- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    //NSLog(@"startLocation");
}
- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    //NSLog(@"stopLocation");
}
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation
{
        NSLog(@"userlocation chanage lo=%f,lat= %f",
              [userLocation location].coordinate.longitude,
              [userLocation location].coordinate.latitude);
//    NSString *str=[NSString stringWithFormat:@"lo=%f,lat= %f",[userLocation location].coordinate.longitude,[userLocation location].coordinate.latitude];
//    [self showAlertView:@"定位结果结果" widthMessage:str];
}

- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

/**************************坐标转换****************************/

- (CLLocationCoordinate2D)convertPoint:(CGPoint)point{
  
    return [_mapView convertPoint:point toCoordinateFromView:_mapView];
}

/**************************线状标注****************************/

- (void)addPolyline:(CLLocationCoordinate2D[])polylineArray withcount:(int)count{

    QPolyline* polyline = [QPolyline polylineWithCoordinates:polylineArray count:count];
    
    [_mapView addOverlay:polyline];
    
    float xMax=-999999999;
    float yMax=-999999999;
    float xMin=999999999;
    float yMin=999999999;
    for (int i=0; i<count; i++) {
        if (polylineArray[i].latitude>xMax) {
            xMax=polylineArray[i].latitude;
        }else if (polylineArray[i].latitude<xMin){
            xMin=polylineArray[i].latitude;
        }
        if (polylineArray[i].longitude>yMax) {
            yMax=polylineArray[i].longitude;
        }else if (polylineArray[i].longitude<yMin){
            yMin=polylineArray[i].longitude;
        }
    }
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake((xMax+xMin)/2,(yMax+yMin)/2);
    
    _mapView.region = QCoordinateRegionMake(CLLocationCoordinate2DMake((xMax+xMin)/2,(yMax+yMin)/2),
                                            QCoordinateSpanMake((xMax-xMin), (yMax-yMin)));
}

-(QOverlayView*)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QPolyline class]]) {
        
        QPolylineView* polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 5.0;
		polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        
        return [polylineView autorelease];
    }
    
    return nil;
    
}
/**************************点状标注****************************/

- (void)addPointAnno:(QPointAnnotation*) pointAnno{
    [_mapView addAnnotation:pointAnno];
}

- (void)removePointAnno:(QPointAnnotation*) pointAnno{
    if(pointAnno){
        [_mapView removeAnnotation:pointAnno];
    }
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation
{
	if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation";
        
        QPinAnnotationView* newAnnotation = (QPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (nil == newAnnotation) {
            newAnnotation = [[QPinAnnotationView alloc]
                             initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
            
            [newAnnotation autorelease];
        }
        
		newAnnotation.pinColor = QPinAnnotationColorRed;
		newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
		
		return newAnnotation;
	}
	return nil;
}


- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    self.mapView = nil;
}

- (void)dealloc
{
    [_mapView release];
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    self.mapView = nil;
    [super dealloc];
}

- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView sizeToFit];
	[alertView show];
	[alertView release];
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    uint64_t start = mach_absolute_time();
    UIImage * image = [UIImage imageNamed:@"pin_yellow.png"];
    //    image.
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/2,image.size.height/2));
    [image drawInRect:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //NSLog(@"%lrli",mach_absolute_time()-start);
    
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
