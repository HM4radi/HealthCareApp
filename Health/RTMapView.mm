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
@synthesize routeCoord;
@synthesize reverseGeocoder=_reverseGeocoder;


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
        routeCoord=[[NSMutableArray alloc]init];
        [_mapView setShowsUserLocation:NO];
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
        
        planData=[RTPlanData shareInstance];
    }
    return self;
}

- (void)showLocation{
    [_mapView setShowsUserLocation:YES];
}

- (NSDictionary*)returnLocationInfo{
    QUserLocation *location=[_mapView userLocation];
    NSString *title=location.title;
    NSString *subtitle=location.subtitle;
    CLLocation *loc=location.location;
    NSDictionary *info=[[NSDictionary alloc]initWithObjectsAndKeys:loc,@"location",title,@"title",subtitle,@"subTitle", nil];
    return info;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (self.selecting) {
        CGPoint pt=[touch locationInView:[touch view]];
        QPointAnnotation* annotation = [[QPointAnnotation alloc]init];
        CLLocationCoordinate2D p=[_mapView convertPoint:pt toCoordinateFromView:[touch view]];
        [annotation setCoordinate:p];
        [annotation setTitle:[NSString stringWithFormat:@"途经点%d",[route count]+1]];
        NSString *coordinate=NSStringFromCGPoint(CGPointMake(p.longitude, p.latitude));
        [routeCoord addObject:coordinate];
        [route addObject:annotation];
        [_mapView addAnnotation:annotation];
        [annotation release];
    }
    return YES;
}

- (void)setSelecting:(BOOL)selecting{
    
    _selecting=selecting;
    
    if (_selecting){
        if ([route count]>0) {
            for (QPointAnnotation* annotation in route){
                [_mapView removeAnnotation:annotation];
                [annotation release];
            }
            [routeCoord removeAllObjects];
            [route removeAllObjects];
            [planData.sportGeoPointDescription removeAllObjects];
        }
    }
}

- (void)removeLastPoint{
    if ([routeCoord count]>0) {
        QPointAnnotation* _annotation=[route lastObject];
        if (_annotation) {
            [routeCoord removeLastObject];
            [route removeLastObject];
            [_mapView removeAnnotation:_annotation];
            [_annotation dealloc];
        }
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
    
}
- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    
}


- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation
{
    [self setCenterCoord:[_mapView userLocation].coordinate];
}


- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
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
    
    //_mapView.centerCoordinate = CLLocationCoordinate2DMake((xMax+xMin)/2,(yMax+yMin)/2);
    
    //_mapView.region = QCoordinateRegionMake(CLLocationCoordinate2DMake((xMax+xMin)/2,(yMax+yMin)/2),QCoordinateSpanMake((xMax-xMin), (yMax-yMin)));
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
        
//        QPinAnnotationView* newAnnotation = (QPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        //if (nil == newAnnotation) {
            QPinAnnotationView* newAnnotation = [[QPinAnnotationView alloc]
                             initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
            
            [newAnnotation autorelease];
        //}
        
		newAnnotation.pinColor = QPinAnnotationColorRed;
		newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
		
		return newAnnotation;
	}
	return nil;
}

/**************************反地理编码****************************/

-(void)returnPlaceName:(NSString*)pt{
    
    CGPoint p=CGPointFromString(pt);
    CLLocationCoordinate2D coor;
    coor.longitude=p.x;
    coor.latitude=p.y;
    
    QReverseGeocoder* geocode = [[QReverseGeocoder alloc] initWithCoordinate:coor];
    geocode.delegate = self;
    self.reverseGeocoder = geocode;
    [geocode release];
    
    [_reverseGeocoder start];
}

- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFindPlacemark:(QPlaceMark *)placeMark
{
    //查询成功时
    planData.querySuccess=YES;
    //planData.location=placeMark.name;
    [planData.sportGeoPointDescription addObject:placeMark.name];
}


- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFailWithError:(QErrorCode) error
{
    //查询失败时
    NSLog(@"查询失败");
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    //self._mapView = nil;
}

- (void)dealloc
{
    [_mapView release];
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    //self.mapView = nil;
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
    //uint64_t start = mach_absolute_time();
    UIImage * image = [UIImage imageNamed:@"pin_yellow.png"];
    //    image.
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/2,image.size.height/2));
    [image drawInRect:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //NSLog(@"%lrli",mach_absolute_time()-start);
    
}

- (CLLocationCoordinate2D*)convertToCoord2D:(NSArray*)data{
    
    int k=[data count];
    CLLocationCoordinate2D* coord=new CLLocationCoordinate2D[k];
    
    for (int i=0; i<k; i++) {
        CGPoint p=CGPointFromString([data objectAtIndex:i]);
        coord[i]=CLLocationCoordinate2DMake(p.y,p.x);
    }
    
    return coord;
}

- (void)setCenterCoord:(CLLocationCoordinate2D)coord{
    //[_mapView setCenterCoordinate:coord animated:YES];
    [_mapView setRegion:QCoordinateRegionMake(coord,QCoordinateSpanMake(0.002, 0.002)) animated:YES];
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
