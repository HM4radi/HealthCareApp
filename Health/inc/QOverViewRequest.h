/*
 ============================================================================
 Name           : QOverViewRequest.h
 Author         : 腾讯SOSO街景地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QOverViewRequest declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>
#import "QTypes.h"
@class QStreetViewPoi;

/**前向声明**/
@protocol QOverViewRequestDelegate;

/**QOverViewRequest:街景地图预览图请求
 *Author:ksnowlv
 **/
@interface QOverViewRequest : NSObject


/**开始查询
 为了后续兼容，使用id类型作为输入类型，
 目前仅支持QPlaceMark类型
 **/
- (BOOL)start:(id)supportObject;

/**撤销查询**/
- (void)cancel;

/**delegate**/
@property(nonatomic, assign) id<QOverViewRequestDelegate> delegate;

/**查询的结果**/
@property(nonatomic, retain) UIImage*  overViewImage;

/**查询的标识**/
@property(nonatomic, readonly, getter=isQuerying) BOOL querying;
@end

@protocol QOverViewRequestDelegate <NSObject>
@required

/**成功时的通知
 *@param request       QOverViewRequest
 *@param overViewImage 查询目标的街景预览图
 *@return
 */
- (void)overViewRequest:(QOverViewRequest *)request didFindOverViewImage:(UIImage *)overViewImage;

/**失败时的通知
 *@param request    QOverViewRequest
 *@param error       见QErrorCode
 *@return
 */
- (void)overViewRequest:(QOverViewRequest *)request didFailWithError:(QErrorCode)error;


@end