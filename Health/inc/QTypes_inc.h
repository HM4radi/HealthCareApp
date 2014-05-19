/*
 ============================================================================
 Name           : QTypes.h
 Author         : 腾讯SOSO街景地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QTypes declaration
 ============================================================================
 */

#ifndef SOSOMapAPI_QTypes_h
#define SOSOMapAPI_QTypes_h

#import <Foundation/Foundation.h>

/**
 *QErrorCode: 错误码
 **/
enum {
    QAppKeyCheckFail = -100,        /** 应用程序验证码验证失败**/
	QDataError = -5,                /** 网络接收的数据错误**/
    QParamError = -4,               /** 网络请求的参数错误**/
    QNetError = -3,                 /** 网络连接错误**/
    QServiceNotSupport = -2,        /** 服务暂不支持**/
    QNotFound= -1,                  /** 没有找到**/
    
	QErrorNone = 0,                 /** 正确，无错误**/
    QNetWorkUnavailable = 0,        /**网络不可用**/
    QNetWorkSignalWeak = 1,         /**网络信号弱**/
};

typedef NSUInteger QErrorCode;

#endif
