/*
 ============================================================================
 Name           : QStreetView.h
 Author         : 腾讯SOSO街景地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QStreetView declaration
 ============================================================================
 */

#import <UIKit/UIKit.h>

/**前向声明**/
@class QStreetViewInfo;
@class QStreetViewOverlay;
@protocol QStreetViewDelegate;

/**
 *QStreetViewShowState街景中的一些显示状态
 *Author:ksnowlv
 **/
typedef enum
{
    QStreetViewShowInit = 0,/**初始状态**/
    QStreetViewShowPresetMap,/**显示预置街景的状态**/
    QStreetViewShowRoad,/**显示街景道路的状态**/
    QStreetViewShowThumbMap,/**显示街景缩略图的状态**/
    QStreetViewShowMap,/**显示街景地图的状态**/
    QStreetViewShowNetError,/**网络错误状态**/
    QStreetViewShowDataError,/**街景网络数据错误状态**/
}QStreetViewShowState;

/**
 *QStreetViewEvent 街景中的一些触摸事件通知
 *Author:ksnowlv
 **/
typedef enum
{
    QStreetViewGestureEventSwipe = 0,/**PanGesture(滑动)事件**/
    QStreetViewGestureEventMove,/**PanGesture(移动)事件**/
    QStreetViewGestureEventDoubleTap,/**double TapGesture事件**/
    QStreetViewGestureEventPinch,/**PinchGesture事件**/
}QStreetViewGestureEvent;

/**QStreetView:街景地图View类,可以显示街景地图窗口，并且对街景地图进行相关的操作,如拖动，放缩等
 *Author:ksnowlv
 **/
@interface QStreetView : UIView

/**
 *设置或获取当前街景地图View的代理
 */
@property(nonatomic, assign) id <QStreetViewDelegate> delegate;

/**
 *返回当前当前街景地图View的经纬度，俯仰角，偏航角
 */
@property(nonatomic, readonly) QStreetViewInfo* streetViewInfo;

/**
 *返回当前当前街景地图View中所有的街景Overlays
 */
@property(nonatomic, readonly) NSArray* overlays;

/**
 *是否支持MotionMagenager响应？默认是支持的。
 */
@property(nonatomic, assign) BOOL isSupportMotionManager;

/**
 *设置俯仰角、偏航角
 *@param pitchAngle 坐标系X轴与水平面的夹角。当X轴的正半轴位于过坐标原点的水平面之上时，俯仰角为正.
 按习惯，俯仰角θ的范围为：-π/2≤θ≤π/2(即[-90,90]);
 *@param yawAngle 偏离航向的角度 -π≤θ≤π(即[-180,180]);
 */
- (void)setPitchAngle:(float)pitchAngle yawAngle:(float)yawAngle;
/**
 *根据街景POI显示街景
 *@param supportObject 目前仅仅支持QPlaceMark类型
 @return 是否可以开始显示街景？
 */
-(BOOL)showStreetView:(id)supportObject;

/**
 *添加Overlay
 NOTICE:需要保证QStreetViewOverlay持有的BitmapData相关数据是合法的。
 *@param streetViewOverlay Overlay的数据
 @return void
 */
- (BOOL)addStreetViewOverlay:(QStreetViewOverlay*)streetViewOverlay;

/**
 *添加Overlays
 NOTICE:需要保证数组中各个QStreetViewOverlay持有的BitmapData相关数据是合法的。
 *@param streetViewOverlays 一组Overlay的数据
 @return void
 */
- (BOOL)addStreetViewOverlays:(NSArray*)streetViewOverlays;

/**
 *删除指定Overlay
 *@param streetViewOverlay Overlay的数据
 @return void
 */
- (BOOL)removeStreetViewOverlay:(QStreetViewOverlay*)streetViewOverlay;

/**
 *删除一组Overlay
 *@param overlays 一组Overlay
 @return void
 */
- (BOOL)removeStreetViewOverlays:(NSArray*)overlays;

/**
 *删除所有Overlay
 @return void
 */
- (BOOL)removeAllStreetViewOverlays;

@end


/**
 *QStreetViewInfoType街景信息的类型
 *Author:ksnowlv
 **/
typedef enum
{
    QStreetViewInfoInit,/**初始状态，首次显示街景时的街景信息**/
    QStreetViewInfoSceneChange,/**场景变换时的街景信息**/
    QStreetViewInfoYawPitchChange/**偏航角或俯仰角变化时的街景信息**/
    
}QStreetViewInfoType;

/**
 *QStreetViewInfo通知用户当前街景的一些信息
 *Author:ksnowlv
 **/

@interface QStreetViewInfo : NSObject

/**街景信息的类型**/
@property(nonatomic,readonly) QStreetViewInfoType streetViewInfoType;
/**
 *位置:经度
 */
@property(nonatomic, readonly) double longitude;

/**
 *位置:纬度
 */
@property(nonatomic, readonly) double latitude;

/**
 *俯仰角
 *@param pitchAngle 坐标系X轴与水平面的夹角。当X轴的正半轴位于过坐标原点的水平面之上时，俯仰角为正.
 按习惯，俯仰角θ的范围为：-π/2≤θ≤π/2
 */
@property(nonatomic, readonly) CGFloat pitchAngle;

/**
 *偏航角 yawAngle 偏离航向的角度 -π≤θ≤π
 */
@property(nonatomic, readonly) CGFloat yawAngle;

@end


/**
 *QStreetViewDelegate:QStreetView的Delegate,streetView通过此类来通知用户对应的事件
 *Author:ksnowlv
 **/
@protocol QStreetViewDelegate <NSObject>

@optional

/**
 *街景地图View状态对外的通知
 *@param streetview     街景地图View
 *@param streetViewShowState 街景地图此时的显示状态
 */
- (void)streetView:(QStreetView *)streetview streetViewShowState:(QStreetViewShowState)streetViewShowState;

/**
 *街景地图View位置变化时会调用
 *@param streetview     街景地图View
 *@param streetViewInfo 街景地图View的一些信息，像位置，偏航角，俯仰角信息
 */
- (void)streetView:(QStreetView *)streetview streetViewInfo:(QStreetViewInfo*)streetViewInfo;


/**
 *街景地图View中街景Overlay选中时会调用
 *@param streetview 街景地图View
 *@param streetViewOverlay 当前选中的街景Overlay
 */
- (void)streetView:(QStreetView *)streetview didSelectStreetViewOverlay:(QStreetViewOverlay*)streetViewOverlay;

/**
 *街景地图View中街景Overlay选中时会调用
 *@param streetview 街景地图View
 *@param streetViewOverlay 当前选中的街景Overlay
 *@param postion 当前点击在街景Overlay上的点在街景VIEW中的位置
 *@param frame 当前选中StreetViewOverlay在街景VIEW中的Frame
 */
- (void)streetView:(QStreetView *)streetview  didSelectStreetViewOverlay:(QStreetViewOverlay*)streetViewOverlay clickPosition:(CGPoint)postion streetViewOverlayFrame:(CGRect)frame;

/**
 *街景地图View移动，双击等事件的通知
 *@param streetview 街景地图View
 *@param gestureEvent QStreetViewGestureEvent
 */
- (void)streetView:(QStreetView *)streetview  didNofifyGestureEvent:(QStreetViewGestureEvent)gestureEvent;


@end


