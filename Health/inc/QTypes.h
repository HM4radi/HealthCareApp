/*
 ============================================================================
 Name           : QTypes.h
 Author         : 腾讯SOSO地图
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QTypes declaration
 ============================================================================
 */

#ifndef SOSOMapAPI_QTypes_h
#define SOSOMapAPI_QTypes_h

#import <Foundation/Foundation.h>

/**
 *QMapType:地图类型
 *Author:ksnowlv
 **/
enum {
    QMapTypeStandard    = 1, /** 标准地图(0X00000001)**/
    QMapTypeTrafficOn   = 2, /** 打开实时路况(0X00000010)**/
    QMapTypeTrafficOff  = 4, /** 关闭实时路况(0X00000100)**/
    QMapTypeSatellite   = 8, /** 卫星地图,暂时不可用(0X00001000)**/
};

/**地图类型**/
typedef NSUInteger QMapType;

/**
 *QErrorCode: errorCode>=0的类型表示正常的类型，其它类型为表示已知的错误类型
 *Author:ksnowlv
 **/
enum {
    QAppKeyCheckFail = -100,        /** 应用程序验证码验证失败**/
    QNetWorkUnavailable = -6,        /**网络不可用**/
	QDataError = -5,                /** 网络接收的数据错误**/
    QParamError = -4,               /** 网络请求的参数错误**/
    QNetError = -3,                 /** 网络连接错误**/
    QServiceNotSupport = -2,        /** 服务暂不支持**/
    QNotFound= -1,                  /** 没有找到**/
    
	QErrorNone = 0,                 /** 正确，无错误**/
    QSmartTripsList,                /** 搜索建议，智能提示**/
    QPoiSearchResultPoiList,        /** POI搜索类型:城市内搜索POI列表**/
    QPoiSearchResultRoundPoi,       /** POI搜索类型:城市内搜索周边POI**/
    QPoiSearchResultCity,           /** POI搜索类型:城市**/
    QPoiSearchResultCrossCityList,  /** POI搜索类型:城市列表**/
    QRouteSearchResultBusList,      /** 路线搜索类型:公交路线搜索返回的起点或终点的选择列表**/
    QRouteSearchResultBusResult,    /** 路线搜索类型:公交路线搜索返回的结果**/
    QRouteSearchResultDriveList,    /** 路线搜索类型:驾车路线搜索返回的起点或终点的选择列表**/
    QRouteSearchResultDriveResult,  /** 路线搜索类型:驾车路线搜索返回的结果**/
    QBusLineSearchResultBusInfo     /** 公交线搜索类型:公交线搜索返回的结果**/
    
};

/**QErrorCode**/
typedef NSUInteger QErrorCode;

#endif
