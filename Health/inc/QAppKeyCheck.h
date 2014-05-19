/*
 ============================================================================
 Name           : QAppKeyCheck.h
 Author         : 腾讯SOSO地图API
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QAppKeyCheck,QAppKeyCheckDelegate declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>
#import "QTypes.h"

/**
 *QAppKeyCheckDelegate:app key 验证的代理
 *Author:ksnowlv
 **/
@protocol QAppKeyCheckDelegate <NSObject>

/**
 *通知APPKey验证的结果
 *@param errCode 见QErrorCode定义
 */
-(void)notifyAppKeyCheckResult:(QErrorCode)errCode;

@end

/**
 *QAppKeyCheck:app key 验证
 *Author:ksnowlv
 **/
@interface QAppKeyCheck : NSObject

/**
 *启动APPKey验证
 *@param key 申请的有效key
 *@param delegate 代理
 */
-(BOOL)start:(NSString*)key withDelegate:(id<QAppKeyCheckDelegate>)delegate;

/**
 *停止或取消APPKey验证
 */
-(void)stop;

@end
