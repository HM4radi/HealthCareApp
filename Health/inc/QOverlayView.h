/*
 ============================================================================
 Name           : QOverlayView.h
 Author         : 腾讯SOSO地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QOverlayView declaration
 ============================================================================
 */

#import <UIKit/UIKit.h>
#import "QGeometry.h"
#import "QOverlay.h"

/**
 *QOverlayView：地图覆盖物View的基类，所有地图覆盖物View需要继承自此类
 *Author:ksnowlv
 **/
@interface QOverlayView : UIView
{
@package
    id <QOverlay> _overlay;
    QMapRect _boundingMapRect;
    CGAffineTransform _mapTransform;
}

/**
 *初始化并返回一个overlay view
 *@param overlay 关联的overlay对象
 *@return 初始化成功则返回overlay view,否则返回nil
 */
- (id)initWithOverlay:(id <QOverlay>)overlay;

/**关联的overlay对象**/
@property(nonatomic, readonly) id <QOverlay> overlay;

/**
 *将直角坐标转为overlay view坐标
 *@param mapPoint 直角坐标
 *@return 对应的view坐标
 */
- (CGPoint)pointForMapPoint:(QMapPoint)mapPoint;

/**
 *将overlay view坐标转为直角坐标
 *@param point view坐标
 *@return 对应的直角坐标
 */
- (QMapPoint)mapPointForPoint:(CGPoint)point;

/**
 *将二维地图投影矩形转为overlay view矩形
 *@param mapRect 二维地图投影矩形
 *@return 对应的view矩形
 */
- (CGRect)rectForMapRect:(QMapRect)mapRect;

/**
 *将overlay view区域转为二维地图投影区域
 *@param rect 指定的view矩形
 *@return 对应的二维地图投影矩形
 */
- (QMapRect)mapRectForRect:(CGRect)rect;

/**
 *判断ovlerlay view是否准备绘制内容
 *默认返回YES，如果用户设为NO，当需要绘制内容时要显示调用setNeedsDisplayInMapRect:zoomScale:方法
 *@param mapRect 需要更新的地图矩形区域
 *@param zoomScale 当前的缩放因子
 *@return 如果view准备好绘制内容，返回YES,否则返回NO
 */
- (BOOL)canDrawMapRect:(QMapRect)mapRect
             zoomScale:(QZoomScale)zoomScale;

/**
 *绘制overlay view内容
 *该方法默认不做任何事，子类需要重载该方法来绘制view的内容
 *@param mapRect 需要更新的地图矩形区域
 *@param zoomScale 当前的缩放因子
 *@param context 使用的graphics context
 */
- (void)drawMapRect:(QMapRect)mapRect
          zoomScale:(QZoomScale)zoomScale
          inContext:(CGContextRef)context;

/**
 *使view在给定矩形的区域无效,系统将重绘该区域
 *@param mapRect 需要更新的区域
 */
- (void)setNeedsDisplayInMapRect:(QMapRect)mapRect;     

/**
 *使view在给定矩形的区域无效,系统将重绘该区域
 *@param mapRect 需要更新的区域
 *@param zoomScale 当前的缩放因子
 */
- (void)setNeedsDisplayInMapRect:(QMapRect)mapRect
                       zoomScale:(QZoomScale)zoomScale;

@end
// Road widths are typically not drawn to scale on the map.  This function
// returns the approximate width in points of roads at the specified zoomScale.
// The result of this function is suitable for use with CGContextSetLineWidth.

CGFloat QRoadWidthAtZoomScale(QZoomScale zoomScale);
