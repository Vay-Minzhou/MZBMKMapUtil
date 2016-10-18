//
//  MZEngineAbout.h
//  DHETC
//
//  Created by liminzhou on 16/9/19.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

///定位信息block
typedef void (^MZLocationBlock)(BMKUserLocation *userLocation);
///正向编码block
typedef void (^MZGeoCodeBlock)(BMKGeoCodeResult *result,BMKSearchErrorCode errorCode);
///反向编码block
typedef void (^MZReverseGeoCodeBlock)(BMKReverseGeoCodeResult *result,BMKSearchErrorCode errorCode);
///POI检索block
typedef void (^MZPoiSearchBlock)(BMKPoiResult *result,BMKSearchErrorCode errorCode);
///关键字联想搜索block
typedef void (^MZKeyordLenoveSearchBlock)(BMKSuggestionResult *result,BMKSearchErrorCode errorCode);

///路径规划block(驾车)
typedef void (^MZPlanDrivingPathBlock)(BMKDrivingRouteResult *result,BMKSearchErrorCode erroeCode);
///路径规划block(公交)
typedef void (^MZPlanTransitPathBlock)(BMKTransitRouteResult *result,BMKSearchErrorCode erroeCode);
///路径规划block(步行)
typedef void (^MZPlanWalkingPathBlock)(BMKWalkingRouteResult *result,BMKSearchErrorCode erroeCode);

///POI详情检索block
typedef void (^MZPoiDetailSearchBlock)(BMKPoiDetailResult *result,BMKSearchErrorCode errorCode);
///公交详情检索block
typedef void (^MZBusLineDetailSearchBlock)(BMKBusLineResult *result,BMKSearchErrorCode errorCode);

///行政区边界数据检索block
typedef void (^MZDistrictSearchBlock)(BMKDistrictResult *result,BMKSearchErrorCode errorCode);

///poi详情短串分享block
typedef void (^MZPoiDetailShareURLBlock)(BMKShareURLResult *result,BMKSearchErrorCode errorCode);
///发起位置信息分享block
typedef void (^MZLocationShareURLBlock)(BMKShareURLResult *result,BMKSearchErrorCode errorCode);
///“公交/驾车/骑行/步行路线规“的划短串分享block
typedef void (^MZRoutePlanShareURLBlock)(BMKShareURLResult *result,BMKSearchErrorCode errorCode);
///离线地图下载更新block
typedef void (^MZOfflineMapDownloadBlock)(int type,int state,BMKOLUpdateElement *updateElement);


@interface MZEngineAbout : NSObject
+ (MZEngineAbout *)sharedInstance;

#pragma mark  ---------------------------------百度地图---------------------------------

#pragma mark - resultBlock
//回调block
@property (nonatomic, copy ) MZLocationBlock            locationBlock;
@property (nonatomic, copy ) MZGeoCodeBlock             geoCodeBlock;
@property (nonatomic, copy ) MZReverseGeoCodeBlock      reverseGeoCodeBlock;
@property (nonatomic, copy ) MZPoiSearchBlock           poiSearchBlock;
@property (nonatomic, copy ) MZKeyordLenoveSearchBlock  keywordLenoveSearchBlock;

//路径规划
@property (nonatomic, copy ) MZPlanDrivingPathBlock     planDrivingPathBlock;
@property (nonatomic, copy ) MZPlanTransitPathBlock     planTransitPathBlock;
@property (nonatomic, copy ) MZPlanWalkingPathBlock     planWalkingPathBlock;

//详情
@property (nonatomic,copy  ) MZPoiDetailSearchBlock     poiDetailSearchBlock;
@property (nonatomic,copy  ) MZBusLineDetailSearchBlock busLineDetailSearchBlock;

//行政区边界数据
@property (nonatomic,copy  ) MZDistrictSearchBlock      districtSearchBlock;

//短串分享
@property (nonatomic,copy  ) MZPoiDetailShareURLBlock   poiDetailShareURLBlock;
@property (nonatomic,copy  ) MZLocationShareURLBlock    locationShareURLBlock;
@property (nonatomic,copy  ) MZRoutePlanShareURLBlock   routePlanShareURLBlock;

//离线地图
@property (nonatomic,copy  ) MZOfflineMapDownloadBlock   offlineMapDownloadBlock;

#pragma mark - Engine

//定位引擎
@property (nonatomic,strong) BMKLocationService         * locationService;

//geo编码引擎
@property (nonatomic,strong) BMKReverseGeoCodeOption    * reverseGeoCodeSearchOption;
@property (nonatomic,strong) BMKGeoCodeSearchOption     * geoCodeSearchOption;
@property (nonatomic,strong) BMKGeoCodeSearch           * geoCodeSearch;

//路线规划搜索引擎
@property (nonatomic,strong) BMKRouteSearch             * routeSearcher;
@property (nonatomic,strong) BMKPlanNode                * start;
@property (nonatomic,strong) BMKPlanNode                * end;
@property (nonatomic,strong) BMKDrivingRoutePlanOption  *drivingRouteSearchOption;
@property (nonatomic,strong) BMKTransitRoutePlanOption  *transitRouteSearchOption;
@property (nonatomic,strong) BMKWalkingRoutePlanOption  *walkingRouteSearchOption;

//POI检索引擎
@property (nonatomic,strong) BMKPoiSearch               *poiSearch;
@property (nonatomic,strong) BMKCitySearchOption        * citySearchOption;
@property (nonatomic,strong) BMKNearbySearchOption      * nearbySearchOption;
@property (nonatomic,strong) BMKBoundSearchOption       * boundSearchOption;
@property (nonatomic,strong) BMKPoiDetailSearchOption   *poiDetailSearchOption;

//线路区域检索
@property (nonatomic,strong) BMKBusLineSearchOption     *busDetailSearchOption;
@property (nonatomic,strong) BMKBusLineSearch           *busLineSearcher;
@property (nonatomic,strong) BMKDistrictSearchOption    *districtSearchOption;
@property (nonatomic,strong) BMKDistrictSearch          *districtSearcher;

//短串分享
@property (nonatomic,strong) BMKShareURLSearch          *shareURLSearcher;
@property (nonatomic,strong) BMKPoiDetailShareURLOption *poiDetailShareOption;
@property (nonatomic,strong) BMKLocationShareURLOption  *locationShareURLOption;
@property (nonatomic,strong) BMKRoutePlanShareURLOption *routePlanShareURLOption;

//关键字联想搜索引擎
@property (nonatomic,strong) BMKSuggestionSearchOption  *suggestSearchOption;
@property (nonatomic,strong) BMKSuggestionSearch        *suggestSearch;

//离线地图
@property (nonatomic,strong) BMKOfflineMap              *offlineMap;

#pragma mark - addDelegate
/**
 *  添加定位代理
 */
- (void)addLocationServiceDelegate;
/**
 *  添加geo编码代理
 */
- (void)addGeoCodeSearchDelegate;
/**
 *  添加Poi检索代理
 */
- (void)addPoiSearchDelegate;
/**
 *  添加关键字检索代理
 */
- (void)addSuggestSearchDelegate;
/**
 *  添加路径规划代理
 */
- (void)addRouteSearcherDelegate;
/**
 *  添加公交线路搜索代理
 */
- (void)addBusLineSearcherDelegate;
/**
 *  添加行政区域搜索代理
 */
- (void)addDistrictSearcherDelegate;
/**
 *  添加短串分享代理
 */
- (void)addShareURLSearcherDelegate;
/**
 *  添加离线地图代理
 */
- (void)addOfflineMapDelegate;

#pragma mark - removeDelegate
/**
 *  移除代理（移除所有）    在析构函数里面实现
 */
- (void)removeAllEngineDelegate;

/**
 *  移除定位代理
 */
- (void)removeLocationServiceDelegate;
/**
 *  移除geo编码代理
 */
- (void)removeGeoCodeSearchDelegate;
/**
 *  移除Poi检索代理
 */
- (void)removePoiSearchDelegate;
/**
 *  移除关键字检索代理
 */
- (void)removeSuggestSearchDelegate;
/**
 *  移除路径规划代理
 */
- (void)removeRouteSearcherDelegate;
/**
 *  移除公交线路搜索代理
 */
- (void)removeBusLineSearcherDelegate;
/**
 *  移除行政区域搜索代理
 */
- (void)removeDistrictSearcherDelegate;
/**
 *  移除短串分享代理
 */
- (void)removeShareURLSearcherDelegate;
/**
 *  移除离线地图代理
 */
- (void)removeOfflineMapDelegate;

#pragma mark - removeEngine
/**
 *  移除引擎，释放内存（移除所有）  在析构函数里面实现
 */
- (void)removeAllEngine;

/**
 *  移除定位引擎
 */
- (void)removeLocationServiceEngine;
/**
 *  移除geo编码引擎
 */
- (void)removeGeoCodeSearchEngine;
/**
 *  移除Poi检索引擎
 */
- (void)removePoiSearchEngine;
/**
 *  移除关键字检索引擎
 */
- (void)removeSuggestSearchEngine;
/**
 *  移除路径规划引擎
 */
- (void)removeRouteSearcherEngine;
/**
 *  移除公交线路搜索引擎
 */
- (void)removeBusLineSearcherEngine;
/**
 *  移除行政区域搜索引擎
 */
- (void)removeDistrictSearcherEngine;
/**
 *  移除短串分享引擎
 */
- (void)removeShareURLSearcherEngine;
/**
 *  移除离线地图引擎
 */
- (void)removeOfflineMapEngine;


#pragma mark  ---------------------------------百度导航---------------------------------

@property (nonatomic, strong) BNRoutePlanNode *startNode;
@property (nonatomic, strong) BNRoutePlanNode *endNode;
@property (nonatomic, strong) NSMutableArray  *nodesArray;
@property (nonatomic, strong) BNPosition      * startPosition;
@property (nonatomic, strong) BNPosition      * endPosition;


@end
