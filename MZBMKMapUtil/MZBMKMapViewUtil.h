

/**
 *  MZBMKMapViewUtil
 *  导入 MZBMKMapViewUtil 之前，需要集成最新的百度地图SDK。
 *  按照百度开发平台的官网文档，导入一些必要的库文件，做好环境配置。
 */

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h> //引入百度地图通用类头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import "BNCoreServices.h"
#import "MZEngineAbout.h"





@interface MZBMKMapViewUtil : NSObject
<
BMKLocationServiceDelegate,
BMKGeoCodeSearchDelegate,
BMKSuggestionSearchDelegate,
BMKPoiSearchDelegate,
BMKRouteSearchDelegate,
BMKBusLineSearchDelegate,
BMKDistrictSearchDelegate,
BMKShareURLSearchDelegate,
BNNaviUIManagerDelegate,
BNNaviRoutePlanDelegate,
BMKGeneralDelegate,
BMKOfflineMapDelegate
>


#pragma mark - sharedInstance
+ (MZBMKMapViewUtil *)sharedInstance;

#pragma mark - <<<<<<<<<<<<<<<<<<<< 百度地图 >>>>>>>>>>>>>>>>>>>>>>


#pragma mark - Engine


/**
 *  初始化百度地图引擎
 *
 *  @param appKey   appKey
 *  @param delegate delegate
 */
+ (void)startBMKMapServices:(NSString *)appKey
            generalDelegate:(id<BMKGeneralDelegate>)delegate;

#pragma mark - start to do Something
/**
 * 开始定位
 * @param locationBlock 定位结果

 */
- (void)startLocationWithCompletionBlock:(MZLocationBlock)locationBlock;

/**
 * 开始正向地理编码
 * @param address 地址
 * @param city 城市名
 * @param geoCodeBlock 正向地理编码检索结果
 
 */
- (void)startGeoCodeWithAddress:(NSString *)address
                        andCity:(NSString *)city
             andCompletionBlock:(MZGeoCodeBlock)geoCodeBlock;

/**
 * 开始反向地理编码（用户定位到的经纬度，返回城市）
 * @param userLocation 用户经纬度
 * @param reverseGeoCodeBlock 反向地理编码检索结果
 */
- (void)startReverseGeoCodeWithUserLocation:(BMKUserLocation *)userLocation
                         andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock;

/**
 * 开始反向地理编码（搜索的位置信息，根据经纬度定位到城市）
 * @param searchLocation 用户经纬度
 * @param reverseGeoCodeBlock 反向地理编码检索结果
 
 */
- (void)startReverseGeoCodeWithSearchLocation:(CLLocationCoordinate2D)searchLocation
                           andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock;

/** 开始POI检索（城市内）
 *@param pageIndex 当前页码（分页形式）
 *@param pageCapacity 每页返回数据条数
 *@param city 城市名
 *@param keyword 关键字
 *@param poiSearchBlock POI检索结果
 
 */
- (void)startPoiCitySearchWithPageIndex:(int)pageIndex
                           pageCapacity:(int)pageCapacity
                                   city:(NSString *)city
                                keyword:(NSString *)keyword
                    WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock;


/** 开始POI检索（周边）
 *@param pageIndex 当前页码（分页形式）
 *@param pageCapacity 每页返回数据条数
 *@param keyword 关键字
 *@param location 中心经纬度
 *@param radius 搜索半径
 *@param sortType 搜索条件（由近到远或综合搜索）
 *@param poiSearchBlock POI检索结果
 
 */
- (void)startPoiNearbySearchWithPageIndex:(int)pageIndex
                             pageCapacity:(int)pageCapacity
                                  keyword:(NSString *)keyword
                                 location:(CLLocationCoordinate2D)location
                                   radius:(int)radius
                                 sortType:(BMKPoiSortType)sortType
                      WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock;


/** 开始POI检索（矩形）
 *@param pageIndex 当前页码（分页形式）
 *@param pageCapacity 每页返回数据条数
 *@param keyword 关键字
 *@param leftBottom 左下角经纬度
 *@param rightTop 右上角经纬度
 *@param poiSearchBlock POI检索结果
 
 */

- (void)startPoiBoundSearchWithPageIndex:(int)pageIndex
                            pageCapacity:(int)pageCapacity
                                 keyword:(NSString *)keyword
                              leftBottom:(CLLocationCoordinate2D)leftBottom
                                rightTop:(CLLocationCoordinate2D)rightTop
                     WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock;


/** 开始关键字联想搜索
 *@param cityName 城市名
 *@param keyword 关键字
 *@param keywordLenoveSearchBlock 关键字联想搜索结果
 
 */

- (void)startKeywordSearchOfLenoveWithCityName:(NSString *)cityName
                                   withKeyword:(NSString *)keyword
                           WithCompletionBlock:(MZKeyordLenoveSearchBlock)keywordLenoveSearchBlock;


/** 开始路径规划（驾车）
 *@param drivingPolicy 根据需要选择驾驶路线（最短时间、最短路程等）
 *@param startName 开始位置
 *@param startCityName 开始城市名
 *@param startLocation 开始位置经纬度
 *@param endName 结束位置
 *@param endCityName 结束位置名
 *@param EndLocation 结束位置经纬度
 *@param planPathBlock 路径规划结果

 */

- (void)startPlanningDrivingPathWithBMKDrivingPolicy:(BMKDrivingPolicy)drivingPolicy
                                       withStartName:(NSString *)startName
                                       withStartCity:(NSString *)startCityName
                                      withStartPoint:(CLLocationCoordinate2D)startLocation
                                         withEndName:(NSString *)endName
                                     withEndCityName:(NSString *)endCityName
                                        withEndPoint:(CLLocationCoordinate2D)EndLocation
                                 WithCompletionBlock:(MZPlanDrivingPathBlock)planPathBlock;



/** 开始路径规划（公交）
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

- (void)startPlanningTransitPathWithBMKTransitPolicy:(BMKTransitPolicy)transitPolicy
                                            withCity:(NSString *)city
                                       withStartName:(NSString *)startName
                                       withStartCity:(NSString *)startCityName
                                      withStartPoint:(CLLocationCoordinate2D)startLocation
                                         withEndName:(NSString *)endName
                                     withEndCityName:(NSString *)endCityName
                                        withEndPoint:(CLLocationCoordinate2D)EndLocation
                                 WithCompletionBlock:(MZPlanTransitPathBlock)planPathBlock;

/** 开始路径规划（步行）
 *@param startName 开始位置
 *@param startCityName 开始城市名
 *@param startLocation 开始位置经纬度
 *@param endName 结束位置
 *@param endCityName 结束位置名
 *@param EndLocation 结束位置经纬度
 *@param planPathBlock 路径规划结果
 
 */

- (void)startPlanningWalkingPathWithStartName:(NSString *)startName
                                withStartCity:(NSString *)startCityName
                               withStartPoint:(CLLocationCoordinate2D)startLocation
                                  withEndName:(NSString *)endName
                              withEndCityName:(NSString *)endCityName
                                 withEndPoint:(CLLocationCoordinate2D)EndLocation
                          WithCompletionBlock:(MZPlanWalkingPathBlock)planPathBlock;

/** 开始POI详情检索
 *@param poiUid 从poi检索返回的BMKPoiResult结构中获取
 *@param poiDetailSearchBlock poi详情检索规划结果
 
 */

- (void)startPoiDetailSearchWithPoiUid:(NSString *)poiUid
                   WithCompletionBlock:(MZPoiDetailSearchBlock)poiDetailSearchBlock;


/** 开始公交详情信息检索
 *@param busLineUid 公交线路的uid
 *@param city 城市名
 *@param busLineDetailSearchBlock 公交详情信息检索结果
 
 */

- (void)startBusDetailSearchWithBusLineUid:(NSString *)busLineUid
                                  withCity:(NSString *)city
                       WithCompletionBlock:(MZBusLineDetailSearchBlock)busLineDetailSearchBlock;

/** 开始行政区边界数据检索
 *@param city 城市名字（必选）
 *@param district 区县名字（可选）
 *@param districtSearchBlock 行政区边界数据检索结果
 
 */

- (void)startDistrictSearchWithCity:(NSString *)city
                       withDistrict:(NSString *)district
                WithCompletionBlock:(MZDistrictSearchBlock)districtSearchBlock;


/** 开始poi详情短串分享
 *@param uid 从poi检索返回的BMKPoiResult结构中获取
 *@param poiDetailShareURLBlock poi详情短串分享结果
 
 */

- (void)startPoiDetailShareOptionWithUid:(NSString *)uid
                     WithCompletionBlock:(MZPoiDetailShareURLBlock)poiDetailShareURLBlock;

/** 开始发起位置信息分享
 *@param snippet 通过短URL调起客户端时作为附加信息显示在名称下面
 *@param name 名称
 *@param location 经纬度
 *@param locationShareURLBlock 位置信息分享结果
 
 */

- (void)startLocationShareURLOptionWithSnippet:(NSString *)snippet
                                      withName:(NSString *)name
                                  withLocation:(CLLocationCoordinate2D)location
                           WithCompletionBlock:(MZLocationShareURLBlock)locationShareURLBlock;


/** 开始“公交/驾车/骑行/步行路线规“的划短串分享
 *@param startName 节点名称（起点）
 *@param startCityID 节点所在城市ID（起点）
 *@param endName 节点名称（终点）
 *@param endCityID 节点所在城市ID（终点）
 *@param routePlanType 路线规划短串分享类型
 *@param cityID 当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
 *@param routeIndex 公交路线规划短串分享时使用，分享的是第几条线路
 *@param routePlanShareURLBlock "公交/驾车/骑行/步行路线规“的划短串分享结果
 
 */

- (void)startRoutePlanShareURLOptionWithStartName:(NSString *)startName
                                  withStartCityID:(NSInteger)startCityID
                                      withEndName:(NSString *)endName
                                    withEndCityID:(NSInteger)endCityID
                                withRoutePlanType:(BMKRoutePlanShareURLType)routePlanType
                                       withCityId:(NSUInteger)cityID
                                   withRouteIndex:(NSInteger)routeIndex
                              WithCompletionBlock:(MZRoutePlanShareURLBlock)routePlanShareURLBlock;

#pragma mark - some private method
/** 获取两点之间的直线距离
 *@param startPointLocation 起点经纬度
 *@param endPointLocation 终点经纬度
 *@return 获取到的直线距离（浮点型，单位：m）
 */

+ (float)getLineDistanceBetweenMapPoints:(CLLocationCoordinate2D)startPointLocation
                        endPointLocation:(CLLocationCoordinate2D)endPointLocation;


/** 传入地图标注数组，确定地图显示范围
 *@param mapView 当前地图
 *@param annotionsArray 标注数组（传入之前把地图上需要显示的所有标注加到数组里）
 */

+ (void)setMapViewZoomLevelWithAnnotions:(BMKMapView *)mapView
                          annotionsArray:(NSMutableArray *)annotionsArray;


/**  根据polyline设置地图范围，路径规划用到
 *@param mapView 当前地图
 *@param polyLine 一段折线路径
 */

+ (void)mapViewFitPolyLine:(BMKMapView *)mapView polyLine:(BMKPolyline *)polyLine;


/** 隐藏百度地图logo，默认显示，如不需隐藏，可忽略这个方法
 *@param mapView 当前地图
 */
+ (void)hideMapViewLogoWithMapView:(BMKMapView *)mapView;

/** 判断当前定位服务是否开启
 *@return 当前定位服务是否开启，（YES为开启，反之）
 */
+ (BOOL)currentLocationServiceIsAvailable;


#pragma mark - <<<<<<<<<<<<<<<<<<<< 百度导航 >>>>>>>>>>>>>>>>>>>>>>

/**
 *  初始化百度导航引擎
 *
 *  @param appKey appKey
 */
+ (void)startBNNavServices:(NSString *)appKey;

/**
 *  开始导航
 *
 *  @param startLocation 起点经纬度
 *  @param endLocation   终点经纬度
 */
- (void)startNavFrom:(CLLocationCoordinate2D)startLocation to:(CLLocationCoordinate2D)endLocation;




#pragma mark - <<<<<<<<<<<<<<<<<<<< 离线地图 >>>>>>>>>>>>>>>>>>>>>>


/**
 开始下载离线地图

 @param cityID                  cityID
 @param offlineMapDownloadBlock 离线地图下载的及时状态
 */
- (void)startDownloadOfflineMapWithCityID:(int)cityID
                      withCompletionBlock:(MZOfflineMapDownloadBlock)offlineMapDownloadBlock;

/**
 开始暂停下载离线地图

 @param cityID cityID

 @return 返回暂停是否成功
 */
- (BOOL)startPauseOfflineMapWithCityID:(int)cityID;

/**
 开始删除离线地图
 
 @param cityID cityID
 
 @return 返回删除是否成功
 */
- (BOOL)startRemoveOfflineMapWithCityID:(int)cityID;

/**
 开始更新离线地图
 
 @param cityID                  cityID
 @param offlineMapDownloadBlock 离线地图更新的及时状态
 */

- (void)startUpdateOfflineMapWithCityID:(int)cityID
                    withCompletionBlock:(MZOfflineMapDownloadBlock)offlineMapDownloadBlock;

/**
 *返回热门城市列表
 *@return 热门城市列表,用户需要显示释放该数组，数组元素为BMKOLSearchRecord
 */
+ (NSArray*)getHotCityList;

/**
 *返回所有支持离线地图的城市列表
 *@return 支持离线地图的城市列表,用户需要显示释放该数组，数组元素为BMKOLSearchRecord
 */
+ (NSArray*)getOfflineCityList;

/**
 *根据城市名搜索该城市离线地图记录
 *@param cityName 城市名
 *@return 该城市离线地图记录,用户需要显示释放该数组，数组元素为BMKOLSearchRecord
 */
+ (NSArray*)searchCity:(NSString*)cityName;

/**
 *返回各城市离线地图更新信息
 *@return 各城市离线地图更新信息,用户需要显示释放该数组，数组元素为BMKOLUpdateElement
 */
+ (NSArray*)getAllUpdateInfo;

/**
 *返回指定城市id离线地图更新信息
 *@param cityID 指定的城市id
 *@return 指定城市id离线地图更新信息
 */
+ (BMKOLUpdateElement*)getUpdateInfo:(int)cityID;

@end




