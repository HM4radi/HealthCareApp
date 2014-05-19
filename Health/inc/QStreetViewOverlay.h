//
//  QStreetViewOverlay.h
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-4-4.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import <Foundation/Foundation.h>


/**显示等级**/
typedef enum
{
    QVisibleLevelFirst = 0,
    QVisibleLevelSecond,
    QVisibleLevelThird,
}QVisibleLevel;

/**
 *QStreetViewOverlay街景中的覆盖物
 *Author:ksnowlv
 **/
@interface QStreetViewOverlay: NSObject

/**标准地理坐标，经度-180～180**/
@property(nonatomic, assign) double longitude;
/**标准地理坐标，纬度-90～90**/
@property(nonatomic, assign) double latitude;
/**距离地面的高度，单位为米**/
@property(nonatomic, assign) double height;
/**显示等级**/
@property(nonatomic, assign) QVisibleLevel visibleLevel;
/**Bitmap数据**/
@property(nonatomic, readonly) void* bitmapData;
/**Bitmap数据长度**/
@property(nonatomic, readonly) NSUInteger bitmapDataLength;
/**Bitmap宽度**/
@property(nonatomic, readonly) NSUInteger bitmapWidth;
/**Bitmap高度**/
@property(nonatomic, readonly) NSUInteger bitmapHeight;
/*附加数据**/
@property(nonatomic, retain) id contextData;
/**是否支持下落动画？默认是支持的**/
@property(nonatomic, assign) BOOL supportDropAnimation;
/**是否支持Overlay近大远小的效果？默认是支持的**/
@property(nonatomic, assign) BOOL supportScaleEffect;

/**
 *设置街景OVERLAY需要数据,深拷贝BitmapData，
 该Overlay添加到街景中后可以把BitmapData相关数据释放掉,
 可以调用releaseBitmapData参数指定为YES
 *@param bitmapData Bitmap数据
 *@param bitmapDataLength Bitmap数据长度
 *@param bitmapWidth Bitmap宽度
 *@param bitmapHeight Bitmap高度
 */

- (void)setBitmapDataWithCopy:(void*)bitmapData bitmapDataLength:(NSUInteger)bitmapDataLength
                  bitmapWidth:(NSUInteger)bitmapWidth bitmapHeight:(NSUInteger)bitmapHeight;

/**
 *设置街景OVERLAY需要数据，浅拷贝BitmapData,
 该Overlay添加到街景中后可以把BitmapData相关数据释放掉，
 可以调用releaseBitmapData参数指定为NO
 NOTICE:建议使用浅拷贝，能尽量减少内存拷贝
 *@param bitmapData Bitmap数据
 *@param bitmapDataLength Bitmap数据长度
 *@param bitmapWidth Bitmap宽度
 *@param bitmapHeight Bitmap高度
 */
- (void)setBitmapDataWithNoCopy:(void*)bitmapData bitmapDataLength:(NSUInteger)bitmapDataLength
                    bitmapWidth:(NSUInteger)bitmapWidth bitmapHeight:(NSUInteger)bitmapHeight;


/**
 *释放街景OVERLAY BitmapData，根据是否深拷贝BitmapData，进行数据释放
 *@param isCopyBitmapData 是否深拷贝BitmapData？
 如果是深拷贝，会释放内部BitmapData，然后重置数据长度，宽，高。
 如果是浅拷贝，仅仅把BitmapData置为NULL，然后重置数据长度，宽，高。
 */
- (void)releaseBitmapData:(BOOL)isCopyBitmapData;

@end


