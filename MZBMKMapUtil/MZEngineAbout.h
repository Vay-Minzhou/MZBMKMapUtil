//
//  MZEngineAbout.h
//  DHETC
//
//  Created by liminzhou on 16/9/19.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZEngineAbout : NSObject
+ (MZEngineAbout *)sharedInstance;

#pragma mark  ---------------------------------百度地图---------------------------------

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

#pragma mark - addAndRemoveDelegate
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
 *  移除代理    在析构函数里面实现
 */
- (void)removeEngineDelegate;
/**
 *  移除引擎，释放内存  在析构函数里面实现
 */
- (void)removeEngine;


#pragma mark  ---------------------------------百度导航---------------------------------

@property (nonatomic, strong) BNRoutePlanNode *startNode;
@property (nonatomic, strong) BNRoutePlanNode *endNode;
@property (nonatomic, strong) NSMutableArray  *nodesArray;
@property (nonatomic, strong) BNPosition      * startPosition;
@property (nonatomic, strong) BNPosition      * endPosition;


@end
