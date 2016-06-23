//
//  MZBMKMapViewUtil.h
//  HuiSongHuo-Owner
//
//  Created by liminzhou on 16/3/8.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h> //引入百度地图通用类头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件



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






@interface MZBMKMapViewUtil : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKSuggestionSearchDelegate,BMKPoiSearchDelegate,BMKRouteSearchDelegate>



//回调block
@property (nonatomic, copy) MZLocationBlock locationBlock;
@property (nonatomic, copy) MZGeoCodeBlock geoCodeBlock;
@property (nonatomic, copy) MZReverseGeoCodeBlock reverseGeoCodeBlock;
@property (nonatomic, copy) MZPoiSearchBlock poiSearchBlock;
@property (nonatomic, copy) MZKeyordLenoveSearchBlock keywordLenoveSearchBlock;

//路径规划
@property (nonatomic, copy) MZPlanDrivingPathBlock planDrivingPathBlock;
@property (nonatomic, copy) MZPlanTransitPathBlock planTransitPathBlock;
@property (nonatomic, copy) MZPlanWalkingPathBlock planWalkingPathBlock;

//详情
@property (nonatomic,copy) MZPoiDetailSearchBlock poiDetailSearchBlock;
@property (nonatomic,copy) MZBusLineDetailSearchBlock busLineDetailSearchBlock;

//行政区边界数据
@property (nonatomic,copy) MZDistrictSearchBlock districtSearchBlock;

//短串分享
@property (nonatomic,copy) MZPoiDetailShareURLBlock poiDetailShareURLBlock;
@property (nonatomic,copy) MZLocationShareURLBlock locationShareURLBlock;
@property (nonatomic,copy) MZRoutePlanShareURLBlock routePlanShareURLBlock;



+ (MZBMKMapViewUtil *)sharedInstance;

/**
 * 开始定位
 * @param locationService 定位服务引擎 
 * @param locationBlock 定位结果

 */
- (void)startLocationWithBMKLocationService:(BMKLocationService *)locationService
                        WithCompletionBlock:(MZLocationBlock)locationBlock;

/**
 * 开始正向地理编码
 * @param geoCodeSearchOption geo检索信息类
 * @param searcher 搜索对象
 * @param address 地址
 * @param city 城市名
 * @param geoCodeBlock 正向地理编码检索结果
 
 */
- (void)startGeoCodeWithAddressWithBMKGeoCodeSearchOption:(BMKGeoCodeSearchOption *)geoCodeSearchOption
                                     withBMKGeoCodeSearch:(BMKGeoCodeSearch *)searcher
                                              withAddress:(NSString *)address
                                                  andCity:(NSString *)city
                                       andCompletionBlock:(MZGeoCodeBlock)geoCodeBlock;

/**
 * 开始反向地理编码（用户定位到的经纬度，返回城市）
 * @param userLocation 用户经纬度
 * @param reverseGeoCodeSearchOption 反geo检索引擎
 * @param searcher 搜索对象
 * @param reverseGeoCodeBlock 反向地理编码检索结果
 */
- (void)startReverseGeoCodeWithUserLocation:(BMKUserLocation *)userLocation
                withBMKReverseGeoCodeOption:(BMKReverseGeoCodeOption *)reverseGeoCodeSearchOption
                       withBMKGeoCodeSearch:(BMKGeoCodeSearch *)searcher
                         andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock;

/**
 * 开始反向地理编码（搜索的位置信息，根据经纬度定位到城市）
 * @param searchLocation 用户经纬度
 * @param reverseGeoCodeSearchOption 反geo检索引擎
 * @param searcher 搜索对象
 * @param reverseGeoCodeBlock 反向地理编码检索结果
 
 */
- (void)startReverseGeoCodeWithSearchLocation:(CLLocationCoordinate2D)searchLocation
                  withBMKReverseGeoCodeOption:(BMKReverseGeoCodeOption *)reverseGeoCodeSearchOption
                         withBMKGeoCodeSearch:(BMKGeoCodeSearch *)searcher
                           andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock;

/** 开始POI检索（城市内）
 *@param citySearchOption 本地云检索参数信息类
 *@param poisearch 搜索服务
 *@param pageIndex 当前页码（分页形式）
 *@param pageCapacity 每页返回数据条数
 *@param city 城市名
 *@param keyword 关键字
 *@param poiSearchBlock POI检索结果
 
 */
- (void)startPoiSearchWithBMKCitySearchOption:(BMKCitySearchOption *)citySearchOption
                             withBMKPoiSearch:(BMKPoiSearch *)poisearch
                                withPageIndex:(int)pageIndex
                                 pageCapacity:(int)pageCapacity
                                         city:(NSString *)city
                                      keyword:(NSString *)keyword2
                          WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock;


/** 开始POI检索（周边）
 *@param nearbySearchOption 本地云检索参数信息类
 *@param poisearch 搜索服务
 *@param pageIndex 当前页码（分页形式）
 *@param pageCapacity 每页返回数据条数
 *@param keyword 关键字
 *@param location 中心经纬度
 *@param radius 搜索半径
 *@param sortType 搜索条件（由近到远或综合搜索）
 *@param poiSearchBlock POI检索结果
 
 */
- (void)startPoiSearchWithBMKNearbySearchOption:(BMKNearbySearchOption *)nearbySearchOption
                             withBMKPoiSearch:(BMKPoiSearch *)poisearch
                                withPageIndex:(int)pageIndex
                                 pageCapacity:(int)pageCapacity
                                      keyword:(NSString *)keyword
                                    location:(CLLocationCoordinate2D)location
                                         radius:(int)radius
                                       sortType:(BMKPoiSortType)sortType
                          WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock;


/** 开始POI检索（矩形）
 *@param boundSearchOption 本地云检索参数信息类
 *@param poisearch 搜索服务
 *@param pageIndex 当前页码（分页形式）
 *@param pageCapacity 每页返回数据条数
 *@param keyword 关键字
 *@param leftBottom 左下角经纬度
 *@param rightTop 右上角经纬度
 *@param poiSearchBlock POI检索结果
 
 */

- (void)startPoiSearchWithBMKBoundSearchOption:(BMKBoundSearchOption *)boundSearchOption
                              withBMKPoiSearch:(BMKPoiSearch *)poisearch
                                 withPageIndex:(int)pageIndex
                                  pageCapacity:(int)pageCapacity
                                       keyword:(NSString *)keyword
                                    leftBottom:(CLLocationCoordinate2D)leftBottom
                                      rightTop:(CLLocationCoordinate2D)rightTop
                           WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock;


/** 开始关键字联想搜索
 *@param suggestionSearchOption sug检索信息类
 *@param suggestSearcher sug搜索服务
 *@param cityName 城市名
 *@param keyword 关键字
 *@param keywordLenoveSearchBlock 关键字联想搜索结果
 
 */

- (void)startKeywordSearchOfLenoveWithBMKSuggestionSearchOption:(BMKSuggestionSearchOption *)suggestionSearchOption
                                        withBMKSuggestionSearch:(BMKSuggestionSearch *)suggestSearcher
                                                   withCityName:(NSString *)cityName
                                                    withKeyword:(NSString *)keyword
                                            WithCompletionBlock:(MZKeyordLenoveSearchBlock)keywordLenoveSearchBlock;


/** 开始路径规划（驾车）
 *@param transitRouteSearchOption 驾车查询基础信息类
 *@param searcher route搜索服务
 *@param start 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
 *@param end 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
 *@param drivingPolicy 根据需要选择驾驶路线（最短时间、最短路程等）
 *@param startName 开始位置
 *@param startCityName 开始城市名
 *@param startLocation 开始位置经纬度
 *@param endName 结束位置
 *@param endCityName 结束位置名
 *@param EndLocation 结束位置经纬度
 *@param planPathBlock 路径规划结果

 */

- (void)startPlanningPathWithBMKDrivingRoutePlanOption:(BMKDrivingRoutePlanOption *)transitRouteSearchOption
                                    WithBMKRouteSearch:(BMKRouteSearch *)searcher
                                       withBMKPlanNode:(BMKPlanNode *)start
                                       withBMKPlanNode:(BMKPlanNode *)end
                                  withBMKDrivingPolicy:(BMKDrivingPolicy)drivingPolicy
                                         withStartName:(NSString *)startName
                                         withStartCity:(NSString *)startCityName
                                        withStartPoint:(CLLocationCoordinate2D)startLocation
                                           withEndName:(NSString *)endName
                                       withEndCityName:(NSString *)endCityName
                                          withEndPoint:(CLLocationCoordinate2D)EndLocation
                                   WithCompletionBlock:(MZPlanDrivingPathBlock)planPathBlock;



/** 开始路径规划（公交）
 *@param transitRouteSearchOption 公交查询基础信息类
 *@param searcher route搜索服务
 *@param start 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
 *@param end 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
 *@param transitPolicy 根据需要选择公交路线（最短时间、最短路程等）
 *@param city 在该城市搜索路径
 *@param startName 开始位置
 *@param startCityName 开始城市名
 *@param startLocation 开始位置经纬度
 *@param endName 结束位置
 *@param endCityName 结束位置名
 *@param EndLocation 结束位置经纬度
 *@param planPathBlock 路径规划结果
 
 */

- (void)startPlanningPathWithBMKTransitRoutePlanOption:(BMKTransitRoutePlanOption *)transitRouteSearchOption
                                    WithBMKRouteSearch:(BMKRouteSearch *)searcher
                                       withBMKPlanNode:(BMKPlanNode *)start
                                       withBMKPlanNode:(BMKPlanNode *)end
                                  withBMKTransitPolicy:(BMKTransitPolicy)transitPolicy
                                              withCity:(NSString *)city
                                         withStartName:(NSString *)startName
                                         withStartCity:(NSString *)startCityName
                                        withStartPoint:(CLLocationCoordinate2D)startLocation
                                           withEndName:(NSString *)endName
                                       withEndCityName:(NSString *)endCityName
                                          withEndPoint:(CLLocationCoordinate2D)EndLocation
                                   WithCompletionBlock:(MZPlanTransitPathBlock)planPathBlock;

/** 开始路径规划（步行）
 *@param transitRouteSearchOption 步行查询基础信息类
 *@param searcher route搜索服务
 *@param start 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
 *@param end 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
 *@param startName 开始位置
 *@param startCityName 开始城市名
 *@param startLocation 开始位置经纬度
 *@param endName 结束位置
 *@param endCityName 结束位置名
 *@param EndLocation 结束位置经纬度
 *@param planPathBlock 路径规划结果
 
 */

- (void)startPlanningPathWithBMKWalkingRoutePlanOption:(BMKWalkingRoutePlanOption *)transitRouteSearchOption
                                    WithBMKRouteSearch:(BMKRouteSearch *)searcher
                                       withBMKPlanNode:(BMKPlanNode *)start
                                       withBMKPlanNode:(BMKPlanNode *)end
                                         withStartName:(NSString *)startName
                                         withStartCity:(NSString *)startCityName
                                        withStartPoint:(CLLocationCoordinate2D)startLocation
                                           withEndName:(NSString *)endName
                                       withEndCityName:(NSString *)endCityName
                                          withEndPoint:(CLLocationCoordinate2D)EndLocation
                                   WithCompletionBlock:(MZPlanWalkingPathBlock)planPathBlock;


/** 开始POI详情检索
 *@param poiDetailSearchOption poi详情检索信息类
 *@param searcher 搜索服务
 *@param poiUid 从poi检索返回的BMKPoiResult结构中获取
 *@param poiDetailSearchBlock poi详情检索规划结果
 
 */

- (void)startPoiDetailSearchWithBMKPoiDetailSearchOption:(BMKPoiDetailSearchOption *)poiDetailSearchOption
                                      WithBMKRouteSearch:(BMKPoiSearch *)searcher
                                              withPoiUid:(NSString *)poiUid
                                     WithCompletionBlock:(MZPoiDetailSearchBlock)poiDetailSearchBlock;


/** 开始公交详情信息检索
 *@param busDetailSearchOption 公交详情检索信息类
 *@param searcher busline搜索服务
 *@param busLineUid 公交线路的uid
 *@param city 城市名
 *@param busLineDetailSearchBlock 公交详情信息检索结果
 
 */

- (void)startBusDetailSearchWithBMKBusLineSearchOption:(BMKBusLineSearchOption *)busDetailSearchOption
                                    WithBMKRouteSearch:(BMKBusLineSearch *)searcher
                                        withBusLineUid:(NSString *)busLineUid
                                              withCity:(NSString *)city
                                   WithCompletionBlock:(MZBusLineDetailSearchBlock)busLineDetailSearchBlock;

/** 开始行政区边界数据检索
 *@param districtSearchOption 行政区域检索信息类
 *@param searcher 行政区域搜索服务
 *@param city 城市名字（必选）
 *@param district 区县名字（可选）
 *@param districtSearchBlock 行政区边界数据检索结果
 
 */

- (void)startDistrictSearchWithBMKDistrictSearchOption:(BMKDistrictSearchOption *)districtSearchOption
                                    WithBMKRouteSearch:(BMKDistrictSearch *)searcher
                                              withCity:(NSString *)city
                                          withDistrict:(NSString *)district
                                   WithCompletionBlock:(MZDistrictSearchBlock)districtSearchBlock;


/** 开始poi详情短串分享
 *@param poiDetailShareOption poi详情短串分享检索信息类
 *@param searcher 短串搜索服务
 *@param uid 从poi检索返回的BMKPoiResult结构中获取
 *@param poiDetailShareURLBlock poi详情短串分享结果
 
 */

- (void)startPoiDetailShareOptionWithBMKPoiDetailShareURLOption:(BMKPoiDetailShareURLOption *)poiDetailShareOption
                                             WithBMKRouteSearch:(BMKShareURLSearch *)searcher
                                                        withUid:(NSString *)uid
                                            WithCompletionBlock:(MZPoiDetailShareURLBlock)poiDetailShareURLBlock;

/** 开始发起位置信息分享
 *@param locationShareURLOption poi详情短串分享检索信息类
 *@param searcher 短串搜索服务
 *@param snippet 通过短URL调起客户端时作为附加信息显示在名称下面
 *@param name 名称
 *@param location 经纬度
 *@param locationShareURLBlock 位置信息分享结果
 
 */

- (void)startLocationShareURLOptionWithBMKPoiDetailShareURLOption:(BMKLocationShareURLOption *)locationShareURLOption
                                               WithBMKRouteSearch:(BMKShareURLSearch *)searcher
                                                      withSnippet:(NSString *)snippet
                                                         withName:(NSString *)name
                                                     withLocation:(CLLocationCoordinate2D)location
                                              WithCompletionBlock:(MZLocationShareURLBlock)locationShareURLBlock;


/** 开始“公交/驾车/骑行/步行路线规“的划短串分享
 *@param routePlanShareURLOption poi详情短串分享检索信息类
 *@param searcher 短串搜索服务
 *@param start 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定(起点)
 *@param end 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定（终点）
 *@param startName 节点名称（起点）
 *@param startCityID 节点所在城市ID（起点）
 *@param endName 节点名称（终点）
 *@param endCityID 节点所在城市ID（终点）
 *@param routePlanType 路线规划短串分享类型
 *@param cityID 当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
 *@param routeIndex 公交路线规划短串分享时使用，分享的是第几条线路
 *@param routePlanShareURLBlock "公交/驾车/骑行/步行路线规“的划短串分享结果
 
 */

- (void)startRoutePlanShareURLOptionWithBMKPoiDetailShareURLOption:(BMKRoutePlanShareURLOption *)routePlanShareURLOption
                                                WithBMKRouteSearch:(BMKShareURLSearch *)searcher
                                                   withBMKPlanNode:(BMKPlanNode *)start
                                                   withBMKPlanNode:(BMKPlanNode *)end
                                                     withStartName:(NSString *)startName
                                                   withStartCityID:(NSInteger)startCityID
                                                       withEndName:(NSString *)endName
                                                     withEndCityID:(NSInteger)endCityID
                                                 withRoutePlanType:(BMKRoutePlanShareURLType)routePlanType
                                                        withCityId:(NSUInteger)cityID
                                                    withRouteIndex:(NSInteger)routeIndex
                                               WithCompletionBlock:(MZRoutePlanShareURLBlock)routePlanShareURLBlock;

/** 获取两点之间的直线距离
 *@param startPointLocation 起点经纬度
 *@param endPointLocation 终点经纬度
 *@return 获取到的直线距离（浮点型，单位：m）
 */

- (float)getLineDistanceBetweenMapPoints:(CLLocationCoordinate2D)startPointLocation
                        endPointLocation:(CLLocationCoordinate2D)endPointLocation;


/** 传入地图标注数组，确定地图显示范围
 *@param mapView 当前地图
 *@param annotionsArray 标注数组（传入之前把地图上需要显示的所有标注加到数组里）
 */

- (void)setMapViewZoomLevelWithAnnotions:(BMKMapView *)mapView
                          annotionsArray:(NSMutableArray *)annotionsArray;


/**  根据polyline设置地图范围，路径规划用到
 *@param mapView 当前地图
 *@param polyLine 一段折线路径
 */

- (void)mapViewFitPolyLine:(BMKMapView *)mapView polyLine:(BMKPolyline *)polyLine;


/** 隐藏百度地图logo，默认显示，如不需隐藏，可忽略这个方法
 *@param mapView 当前地图
 */
- (void)hideMapViewLogoWithMapView:(BMKMapView *)mapView;

/** 判断当前定位服务是否开启
 *@return 当前定位服务是否开启，（YES为开启，反之）
 */
- (BOOL)currentLocationServiceIsAvailable;

@end




