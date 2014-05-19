/*
 ============================================================================
 Name           : QSearch.h
 Author         : 腾讯SOSO地图API
 Version        : 1.0
 Copyright      : 腾讯
 Description    : QSearch declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "QRouteSearch.h"
#import "QPoiSearch.h"

/**前向声明**/
@protocol QSearchDelegate;
@class QSearchInternal;


/**
 *QSearch:POI，周边，路线，公交，驾车等搜索服务
 *Author:ksnowlv
 **/
@interface QSearch : NSObject
{
    QSearchInternal* _internal;
}

/**Search Delegate**/
@property(nonatomic, assign) id<QSearchDelegate> delegate;

/**
 *设置每页容量
 *支持1-50.默认为10,对下一次检索有效,如果在pageCapacity小于1或大于50时,则会设置为默认值10
 *@param capacity 指定的每页POI最大数目
 *返回每页容量(1-50之间)
 */
@property(nonatomic, assign) NSInteger pageCapacity;

/**
 *根据地理坐标获取城市名
 *@param locationCoordinate2D 地理坐标
 *@return 成功返回城市名，否则返回nil
 */
- (NSString*)getCityNameFromPos:(CLLocationCoordinate2D)locationCoordinate2D;

/**
 *城市POI搜索
 *异步函数，返回结果在QSearchDelegate的notifyPoiSearchResult通知
 *@param city 城市名 不能为空
 *@param key 关键词 不能为空
 *@param index 页码，如果是第一次发起搜索，填0，根据返回的结果可以去获取第n页的结果，页码从0开始
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)poiSearchInCity:(NSString*)city withKey:(NSString*)key pageIndex:(NSInteger)index;

/**
 *根据范围和检索词发起范围搜索
 *异步函数，返回结果在QSearchDelegate的notifyPoiSearchResult通知
 *@param key 关键词  不能为空
 *@param leftTopGeo 地理坐标，范围的左上角
 *@param rightBottomGeo 地理坐标，范围的右下角
 *@param index 页码，如果是第一次发起搜索，填0，根据返回的结果可以去获取第n页的结果，页码从0开始
 *NOTICE:地理坐标 The degree can be positive (North and East) or negative (South and West)
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)poiSearchInbounds:(NSString*)key leftTop:(CLLocationCoordinate2D)leftTopGeo 
                 rightBottom:(CLLocationCoordinate2D)rightBottomGeo pageIndex:(NSInteger)index;

/**
 *周边搜索
 *异步函数，返回结果在QSearchDelegate的notifyPoiSearchResult通知
 *@param city 城市名 不能为空
 *@param location 搜索的位置
 *@param radius 搜索半径(单位:KM)
 *@param key 关键词 不能为空
 *@param index 页码，如果是第一次发起搜索，填0，根据返回的结果可以去获取第n页的结果，页码从0开始
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)roundSearch:(NSString*)city location:(CLLocationCoordinate2D) coordinate 
           inRadius:(NSInteger)radius  withKey:(NSString*)key 
          pageIndex:(NSInteger)index;

/**
 *公交路线搜索
 *异步函数，返回结果在QSearchDelegate的notifyRouteSearchResult通知
 *@param city 城市名，用于在哪个城市内进行检索
 *@param start 检索的起点，可通过关键字方式指定
 *@param end 检索的终点，可通过关键字方式指定
 *@param busSearchType 公交路线搜索类型，见QBusSearchType的定义
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)busSearch:(NSString*)city start:(NSString*)start end:(NSString*)end  
            withBusSearchType:(QBusSearchType) busSearchType;

/**
 *公交路线搜索
 *异步函数，返回结果在QSearchDelegate的notifyRouteSearchResult通知
 *@param city 城市名，用于在哪个城市内进行检索
 *@param start 检索的起点，可以从公交路线搜索的起点选择列表中选取
 *@param end 检索的终点，可以从公交路线搜索的终点选择列表中选取
 *@param busSearchType 公交路线搜索类型，见QBusSearchType的定义
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)busSearchWithLocation:(NSString*)city start:(QPlaceInfo*)start end:(QPlaceInfo*)end 
            withBusSearchType:(QBusSearchType) busSearchType;

/**
 *驾乘路线搜索
 *异步函数，返回结果在QSearchDelegate的notifyRouteSearchResult通知
 *@param startCity 起点所在城市
 *@param start 检索的起点，可通过关键字方式指定
 *@param endCity 终点所在城市
 *@param end 检索的终点，可通过关键字方式指定
 *@param driveSearchType 驾车路线搜索类型，见QDriveSearchType的定义
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)drivingSearch:(NSString*)startCity start:(NSString*)start 
              endCity:(NSString*)endCity end:(NSString*)end 
  withDriveSearchType:(QDriveSearchType)driveSearchType;

/**
 *驾乘路线搜索
 *异步函数，返回结果在QSearchDelegate的notifyRouteSearchResult通知
 *@param startCity 起点所在城市
 *@param start 检索的起点，可以从驾车路线搜索的起点选择列表中选取
 *@param endCity 终点所在城市
 *@param end 检索的终点，可以从驾车路线搜索的终点选择列表中选取
 *@param driveSearchType 驾车路线搜索类型，见QDriveSearchType的定义
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)drivingSearchWithLocation:(NSString*)startCity start:(QPlaceInfo*)start
              endCity:(NSString*)endCity end:(QPlaceInfo*)end
  withDriveSearchType:(QDriveSearchType)driveSearchType;


/**
 *公交线搜索
 *异步函数，返回结果在QSearchDelegate的notifyBusLineSearchResult通知
 *@param uid 公交UID
 */
- (BOOL)busLineSearch:(NSString*)uid;

/**
 *智能提示
 *异步函数，返回结果在QSearchDelegate的notifyQQRoundBusResult通知
 *@param (NSString*)city:当前城市
 *@param (NSString*)keyWord:搜索关键字
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)smartTripSearch:(NSString*)city widthKeyWord:(NSString*)keyWord;

@end


/**
 *QSearchDelegate:POI，周边，路线，公交，驾车等搜索结果的通知
 *Author:ksnowlv
 **/
@protocol QSearchDelegate<NSObject>

@optional
/**
 *返回POI搜索结果，对QPoiResult中的errorCode而言
 当errorCode为QPoiSearchResultPoiList或QPoiSearchResultRoundPoi时, data是NSArray存放的是QPoiInfo
 当errorCode为QPoiSearchResultCity时, data是QPoiInfo
 当errorCode为QPoiSearchResultCrossCityList时, data是NSArray存放的是QCityInfoForPoi
 其他为非正常状态,可以参见QErrorCode
 
 @param poiResult POI搜索结果
 */
- (void)notifyPoiSearchResult:(QPoiSearchResult*)poiSearchResult;

/**
 *返回智能提示，搜索建议的结果 对smartTripsResult中的errorCode而言
 当errorCode为QSmartTripsList时, data是NSArray,存放的是NSString
 其他为非正常状态,可以参见QErrorCode
 
 @param busLineSearchResult 公交线搜索结果
 */
- (void)notifySmartTripsResult:(QSmartTripsResult*)smartTripsResult;

/**
 *返回路线搜索结果 对routeSearchResult中的errorCode而言
 当errorCode为QRouteSearchResultBusList或QRouteSearchResultDriveList时,data为QRouteQueryResultChoice，
 当errorCode为QRouteSearchResultBusResult时,data为QRoutePlan，
 当errorCode为QRouteSearchResultDriveResult时,data为QRouteInfoForDrive，
 其他为非正常状态,可以参见QErrorCode
 
 @param routeSearchResult 路线搜索结果
 */
- (void)notifyRouteSearchResult:(QRouteSearchResult*)routeSearchResult;

/**
 *返回公交线搜索结果 对busLineSearchResult中的errorCode而言
 当errorCode为QBusLineSearchResultBusInfo时,data为QBusInfo,
 其他为非正常状态,可以参见QErrorCode
 
 @param busLineSearchResult 公交线搜索结果
 */
- (void)notifyBusLineSearchResult:(QBusLineSearchResult*)busLineSearchResult;

@end