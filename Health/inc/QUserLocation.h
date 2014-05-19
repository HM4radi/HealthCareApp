/*
 ============================================================================
 Name           : QUserLocation.h
 Author         : 腾讯SOSO地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QUserLocation declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>
#import "QAnnotation.h"

/**前向声明**/
@class CLLocation;
@class QUserLocationInternal;

/**
 *QUserLocation:定位信息类
 *Author:ksnowlv
 **/
@interface QUserLocation : NSObject <QAnnotation>
{
    QUserLocationInternal* _internal;
}

/**位置更新状态，如果正在更新位置信息，则该值为YES**/
@property(readonly, nonatomic, getter=isUpdating) BOOL updating;

/**位置信息，如果QMapView的showsUserLocation为NO，或者尚未定位成功，则该值为nil**/
@property(retain, nonatomic) CLLocation *location;

/**定位标注点要显示的标题信息**/
@property(nonatomic, copy) NSString *title;

/**定位标注点要显示的副标题信息.**/
@property(nonatomic, copy) NSString *subtitle;

@end
