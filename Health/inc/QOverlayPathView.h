/*
 ============================================================================
 Name           : QOverlayPathView.h
 Author         : 腾讯SOSO地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QOverlayPathView declaration
 ============================================================================
 */

#import "QOverlayView.h"

/**
 *QOverlayPathView：定义了OverlayView，并且在MapKit中定制了几个经常使用的OverlayView
 *Author:ksnowlv
 **/
@interface QOverlayPathView : QOverlayView{
@package
    UIColor *_fillColor;
    UIColor *_strokeColor;
    CGFloat _lineWidth;
    CGLineJoin _lineJoin;
    CGLineCap _lineCap;
    CGFloat _miterLimit;
    CGFloat _lineDashPhase;
    NSArray *_lineDashPattern;
    
    CGPathRef _path;
}

/**填充颜色**/
@property(nonatomic, retain) UIColor *fillColor;
/**画笔颜色**/
@property(nonatomic, retain) UIColor *strokeColor;

/**画笔宽度，默认为0**/
@property(nonatomic, assign) CGFloat lineWidth; 
/** LineJoin，默认为kCGLineJoinRound**/
@property(nonatomic, assign) CGLineJoin lineJoin;
/**LineCap，默认为kCGLineCapRound**/
@property(nonatomic, assign) CGLineCap lineCap;
/**miterLimit,在样式为kCGLineJoinMiter时有效，默认为10**/
@property(nonatomic, assign) CGFloat miterLimit; 
/**lineDashPhase, 默认为0**/
@property(nonatomic, assign) CGFloat lineDashPhase; 
/**lineDashPattern,一个NSNumbers的数组，默认为nil**/
@property(nonatomic, copy) NSArray *lineDashPattern;

/**
 *生成要绘制的path，子类需要重写此函数，并且对path属性赋值：self.path = newPath;
 */
- (void)createPath;

/**path对象**/
@property CGPathRef path;

/**
 *刷新path，调用该函数将会使已经缓存的path失效，将会重新调用createPath来生成新的path对象
 */
- (void)invalidatePath;

/**
 *应用画笔属性
 *@param context CGContext对象
 *@param zoomScale 当前的zoomScale
 */
- (void)applyStrokePropertiesToContext:(CGContextRef)context
                           atZoomScale:(QZoomScale)zoomScale;
/**
 *应用画刷属性
 *@param context CGContext对象
 *@param zoomScale 当前的zoomScale
 */
- (void)applyFillPropertiesToContext:(CGContextRef)context
                         atZoomScale:(QZoomScale)zoomScale;
/**
 *绘制path
 *@param path 要绘制的CGPath
 *@param context CGContext对象
 */
- (void)strokePath:(CGPathRef)path inContext:(CGContextRef)context;

/**
 *填充path
 *@param path 要绘制的CGPath
 *@param context CGContext对象
 */
- (void)fillPath:(CGPathRef)path inContext:(CGContextRef)context;

@end
