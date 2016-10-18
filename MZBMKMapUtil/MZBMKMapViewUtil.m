
/**
 *  MZBMKMapViewUtil
 */

#import "MZBMKMapViewUtil.h"

@implementation MZBMKMapViewUtil

#pragma mark - sharedInstance

+ (MZBMKMapViewUtil*)sharedInstance
{
    static MZBMKMapViewUtil *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MZBMKMapViewUtil alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - <<<<<<<<<<<<<<<<<<<< 百度地图 >>>>>>>>>>>>>>>>>>>>>>
+ (void)startBMKMapServices:(NSString *)appKey
            generalDelegate:(id<BMKGeneralDelegate>)delegate{
    
    BMKMapManager*bmkManager = [[BMKMapManager alloc] init];
    BOOL ret = [bmkManager start:appKey generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

#pragma mark - 开始定位服务

- (void)startLocationWithCompletionBlock:(MZLocationBlock)locationBlock {
    [MZEngineAbout sharedInstance].locationBlock = locationBlock;
    /** 启动LocationService */
    [[MZEngineAbout sharedInstance].locationService startUserLocationService];
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    //NSLog(@"heading is %@",userLocation.heading);
    [MZEngineAbout sharedInstance].locationBlock(userLocation);
    [[[MZEngineAbout sharedInstance] locationService] stopUserLocationService];
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [MZEngineAbout sharedInstance].locationBlock(userLocation);
    [[[MZEngineAbout sharedInstance] locationService] stopUserLocationService];
    
}
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    NSLog(@"willStartLocatingUser");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    NSLog(@"didStopLocatingUser");
}
#pragma mark - 开始正向地理编码（根据位置信息获取经纬度）

//开始正向地理编码
- (void)startGeoCodeWithAddress:(NSString *)address
                        andCity:(NSString *)city
             andCompletionBlock:(MZGeoCodeBlock)geoCodeBlock;
{
    [MZEngineAbout sharedInstance].geoCodeBlock = geoCodeBlock;
    
    [MZEngineAbout sharedInstance].geoCodeSearchOption.address = address;
    [MZEngineAbout sharedInstance].geoCodeSearchOption.city = city;
    BOOL flag = [[MZEngineAbout sharedInstance].geoCodeSearch geoCode:[MZEngineAbout sharedInstance].geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}


// 接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    [MZEngineAbout sharedInstance].geoCodeBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 开始反向地理编码（根据经纬度获取位置信息）
//开始反向地理编码（用户定位到的经纬度，返回城市）
- (void)startReverseGeoCodeWithUserLocation:(BMKUserLocation *)userLocation
                         andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock
{
    [MZEngineAbout sharedInstance].reverseGeoCodeBlock = reverseGeoCodeBlock;
    NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    [MZEngineAbout sharedInstance].reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [[MZEngineAbout sharedInstance].geoCodeSearch reverseGeoCode:[MZEngineAbout sharedInstance].reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

//开始反向地理编码（搜索的位置信息，根据经纬度定位到城市）
- (void)startReverseGeoCodeWithSearchLocation:(CLLocationCoordinate2D)searchLocation
                           andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock
{
    
    [MZEngineAbout sharedInstance].reverseGeoCodeBlock = reverseGeoCodeBlock;
    
    [MZEngineAbout sharedInstance].reverseGeoCodeSearchOption.reverseGeoPoint = searchLocation;
    BOOL flag = [[MZEngineAbout sharedInstance].geoCodeSearch reverseGeoCode:[MZEngineAbout sharedInstance].reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    [MZEngineAbout sharedInstance].reverseGeoCodeBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 开始POI检索（城市内、周边、矩形）
// 开始城市内POI检索

- (void)startPoiCitySearchWithPageIndex:(int)pageIndex
                           pageCapacity:(int)pageCapacity
                                   city:(NSString *)city
                                keyword:(NSString *)keyword
                    WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock
{
    
    [MZEngineAbout sharedInstance].poiSearchBlock = poiSearchBlock;
    //POI检索
    [MZEngineAbout sharedInstance].citySearchOption.pageIndex = pageIndex;
    [MZEngineAbout sharedInstance].citySearchOption.pageCapacity = pageCapacity;
    [MZEngineAbout sharedInstance].citySearchOption.city = city;
    [MZEngineAbout sharedInstance].citySearchOption.keyword = keyword;
    BOOL flag = [[MZEngineAbout sharedInstance].poiSearch poiSearchInCity:[MZEngineAbout sharedInstance].citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
}

//开始周边poi搜索
- (void)startPoiNearbySearchWithPageIndex:(int)pageIndex
                             pageCapacity:(int)pageCapacity
                                  keyword:(NSString *)keyword
                                 location:(CLLocationCoordinate2D)location
                                   radius:(int)radius
                                 sortType:(BMKPoiSortType)sortType
                      WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock
{
    
    [MZEngineAbout sharedInstance].poiSearchBlock = poiSearchBlock;
    
    [MZEngineAbout sharedInstance].nearbySearchOption.pageIndex = pageIndex;
    [MZEngineAbout sharedInstance].nearbySearchOption.pageCapacity = pageCapacity;
    [MZEngineAbout sharedInstance].nearbySearchOption.keyword = keyword;
    [MZEngineAbout sharedInstance].nearbySearchOption.location = location;
    [MZEngineAbout sharedInstance].nearbySearchOption.radius = radius;
    [MZEngineAbout sharedInstance].nearbySearchOption.sortType = sortType;
    
    BOOL flag = [[MZEngineAbout sharedInstance].poiSearch poiSearchNearBy:[MZEngineAbout sharedInstance].nearbySearchOption];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
}

//开始矩形poi搜索
- (void)startPoiBoundSearchWithPageIndex:(int)pageIndex
                            pageCapacity:(int)pageCapacity
                                 keyword:(NSString *)keyword
                              leftBottom:(CLLocationCoordinate2D)leftBottom
                                rightTop:(CLLocationCoordinate2D)rightTop
                     WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock
{
    
    [MZEngineAbout sharedInstance].poiSearchBlock = poiSearchBlock;
    
    [MZEngineAbout sharedInstance].boundSearchOption.pageIndex = pageIndex;
    [MZEngineAbout sharedInstance].boundSearchOption.pageCapacity = pageCapacity;
    [MZEngineAbout sharedInstance].boundSearchOption.keyword = keyword;
    [MZEngineAbout sharedInstance].boundSearchOption.leftBottom = leftBottom;
    [MZEngineAbout sharedInstance].boundSearchOption.rightTop = rightTop;
    
    BOOL flag = [[MZEngineAbout sharedInstance].poiSearch poiSearchInbounds:[MZEngineAbout sharedInstance].boundSearchOption];
    if(flag)
    {
        NSLog(@"矩形检索发送成功");
    }
    else
    {
        NSLog(@"矩形检索发送失败");
    }
    
}



//代理方法获取poi检索结果
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    [MZEngineAbout sharedInstance].poiSearchBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在这里处理正常结果
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}


#pragma mark - 开始关键字联想搜索
// 开始关键字联想搜索
- (void)startKeywordSearchOfLenoveWithCityName:(NSString *)cityName
                                   withKeyword:(NSString *)keyword
                           WithCompletionBlock:(MZKeyordLenoveSearchBlock)keywordLenoveSearchBlock

{
    
    [MZEngineAbout sharedInstance].keywordLenoveSearchBlock = keywordLenoveSearchBlock;
    //关键字联想代码
    [MZEngineAbout sharedInstance].suggestSearchOption.cityname = cityName;
    [MZEngineAbout sharedInstance].suggestSearchOption.keyword  = keyword;
    BOOL flag = [[MZEngineAbout sharedInstance].suggestSearch suggestionSearch:[MZEngineAbout sharedInstance].suggestSearchOption];
    
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
    
}

//关键字联想代理方法
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error{
    
    [MZEngineAbout sharedInstance].keywordLenoveSearchBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
    
}

#pragma mark - 开始路径规划（驾车、公交、步行）
//开始路径规划（驾车）
- (void)startPlanningDrivingPathWithBMKDrivingPolicy:(BMKDrivingPolicy)drivingPolicy
                                       withStartName:(NSString *)startName
                                       withStartCity:(NSString *)startCityName
                                      withStartPoint:(CLLocationCoordinate2D)startLocation
                                         withEndName:(NSString *)endName
                                     withEndCityName:(NSString *)endCityName
                                        withEndPoint:(CLLocationCoordinate2D)EndLocation
                                 WithCompletionBlock:(MZPlanDrivingPathBlock)planPathBlock

{
    
    [MZEngineAbout sharedInstance].planDrivingPathBlock = planPathBlock;
    
    [MZEngineAbout sharedInstance].start.name = startName;
    [MZEngineAbout sharedInstance].start.cityName = startCityName;
    [MZEngineAbout sharedInstance].start.pt = startLocation;
    [MZEngineAbout sharedInstance].end.name = endName;
    [MZEngineAbout sharedInstance].end.cityName = endCityName;
    [MZEngineAbout sharedInstance].end.pt = EndLocation;
    
    [MZEngineAbout sharedInstance].drivingRouteSearchOption.from = [MZEngineAbout sharedInstance].start;
    [MZEngineAbout sharedInstance].drivingRouteSearchOption.to = [MZEngineAbout sharedInstance].end;
    [MZEngineAbout sharedInstance].drivingRouteSearchOption.drivingPolicy = drivingPolicy;
    
    BOOL flag = [[MZEngineAbout sharedInstance].routeSearcher drivingSearch:[MZEngineAbout sharedInstance].drivingRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"驾车检索发送成功");
    }
    else
    {
        NSLog(@"驾车检索发送失败");
    }
    
}

//获取路径规划得到的信息(驾车)
-(void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    [MZEngineAbout sharedInstance].planDrivingPathBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        //当路线起终点有歧义时通，获取建议检索起终点
        //result.routeAddrResult
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
    
}


//开始路径规划（公交）
- (void)startPlanningTransitPathWithBMKTransitPolicy:(BMKTransitPolicy)transitPolicy
                                            withCity:(NSString *)city
                                       withStartName:(NSString *)startName
                                       withStartCity:(NSString *)startCityName
                                      withStartPoint:(CLLocationCoordinate2D)startLocation
                                         withEndName:(NSString *)endName
                                     withEndCityName:(NSString *)endCityName
                                        withEndPoint:(CLLocationCoordinate2D)EndLocation
                                 WithCompletionBlock:(MZPlanTransitPathBlock)planPathBlock
{
    
    
    [MZEngineAbout sharedInstance].planTransitPathBlock = planPathBlock;
    
    [MZEngineAbout sharedInstance].start.name = startName;
    [MZEngineAbout sharedInstance].start.cityName = startCityName;
    [MZEngineAbout sharedInstance].start.pt = startLocation;
    [MZEngineAbout sharedInstance].end.name = endName;
    [MZEngineAbout sharedInstance].end.cityName = endCityName;
    [MZEngineAbout sharedInstance].end.pt = EndLocation;
    
    [MZEngineAbout sharedInstance].transitRouteSearchOption.from = [MZEngineAbout sharedInstance].start;
    [MZEngineAbout sharedInstance].transitRouteSearchOption.to = [MZEngineAbout sharedInstance].end;
    [MZEngineAbout sharedInstance].transitRouteSearchOption.city = city;
    [MZEngineAbout sharedInstance].transitRouteSearchOption.transitPolicy = transitPolicy;
    
    BOOL flag = [[MZEngineAbout sharedInstance].routeSearcher transitSearch:[MZEngineAbout sharedInstance].transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }
    
}


- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    [MZEngineAbout sharedInstance].planTransitPathBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
    }else{
        
    }
}


//开始路径规划（步行）
- (void)startPlanningWalkingPathWithStartName:(NSString *)startName
                                withStartCity:(NSString *)startCityName
                               withStartPoint:(CLLocationCoordinate2D)startLocation
                                  withEndName:(NSString *)endName
                              withEndCityName:(NSString *)endCityName
                                 withEndPoint:(CLLocationCoordinate2D)EndLocation
                          WithCompletionBlock:(MZPlanWalkingPathBlock)planPathBlock
{
    
    [MZEngineAbout sharedInstance].planWalkingPathBlock = planPathBlock;
    
    [MZEngineAbout sharedInstance].start.name = startName;
    [MZEngineAbout sharedInstance].start.cityName = startCityName;
    [MZEngineAbout sharedInstance].start.pt = startLocation;
    [MZEngineAbout sharedInstance].end.name = endName;
    [MZEngineAbout sharedInstance].end.cityName = endCityName;
    [MZEngineAbout sharedInstance].end.pt = EndLocation;
    
    [MZEngineAbout sharedInstance].walkingRouteSearchOption.from = [MZEngineAbout sharedInstance].start;
    [MZEngineAbout sharedInstance].walkingRouteSearchOption.to = [MZEngineAbout sharedInstance].end;
    
    BOOL flag = [[MZEngineAbout sharedInstance].routeSearcher walkingSearch:[MZEngineAbout sharedInstance].walkingRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"步行检索发送成功");
    }
    else
    {
        NSLog(@"步行检索发送失败");
    }
    
    
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error{
    
    [MZEngineAbout sharedInstance].planWalkingPathBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
    }else{
        
    }
}

#pragma mark - 开始POI详情检索
- (void)startPoiDetailSearchWithPoiUid:(NSString *)poiUid
                   WithCompletionBlock:(MZPoiDetailSearchBlock)poiDetailSearchBlock{
    
    [MZEngineAbout sharedInstance].poiDetailSearchBlock = poiDetailSearchBlock;
    
    [MZEngineAbout sharedInstance].poiDetailSearchOption.poiUid = poiUid;
    
    BOOL flag = [[MZEngineAbout sharedInstance].poiSearch poiDetailSearch:[MZEngineAbout sharedInstance].poiDetailSearchOption];
    
    if(flag)
    {
        NSLog(@"poi详情检索发起成功");
    }
    else
    {
        NSLog(@"poi详情检索发起失败");
    }
    
    
}
//代理监听检索结果
-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode{
    
    [MZEngineAbout sharedInstance].poiDetailSearchBlock(poiDetailResult,errorCode);
    
    if(errorCode == BMK_SEARCH_NO_ERROR){
        //在此处理正常结果
    }
}


#pragma mark - 公交详情信息检索
- (void)startBusDetailSearchWithBusLineUid:(NSString *)busLineUid
                                  withCity:(NSString *)city
                       WithCompletionBlock:(MZBusLineDetailSearchBlock)busLineDetailSearchBlock
{
    
    [MZEngineAbout sharedInstance].busLineDetailSearchBlock = busLineDetailSearchBlock;
    
    
    [MZEngineAbout sharedInstance].busDetailSearchOption.busLineUid = busLineUid;
    [MZEngineAbout sharedInstance].busDetailSearchOption.city = city;
    
    BOOL flag = [[MZEngineAbout sharedInstance].busLineSearcher busLineSearch:[MZEngineAbout sharedInstance].busDetailSearchOption];
    
    if(flag)
    {
        NSLog(@"busline检索发送成功");
    }
    else
    {
        NSLog(@"busline检索");
    }
    
    
}

//实现PoiSearchDeleage处理回调结果
- (void)onGetBusDetailResult:(BMKBusLineSearch*)searcher result:(BMKBusLineResult*)busLineResult errorCode:(BMKSearchErrorCode)error
{
    
    [MZEngineAbout sharedInstance].busLineDetailSearchBlock(busLineResult,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 行政区边界数据检索
- (void)startDistrictSearchWithCity:(NSString *)city
                       withDistrict:(NSString *)district
                WithCompletionBlock:(MZDistrictSearchBlock)districtSearchBlock
{
    
    [MZEngineAbout sharedInstance].districtSearchBlock = districtSearchBlock;
    
    [MZEngineAbout sharedInstance].districtSearchOption.city = city;
    [MZEngineAbout sharedInstance].districtSearchOption.district = district;
    
    //发起检索
    BOOL flag = [[MZEngineAbout sharedInstance].districtSearcher districtSearch:[MZEngineAbout sharedInstance].districtSearchOption];
    
    if (flag) {
        NSLog(@"district检索发送成功");
    } else {
        NSLog(@"district检索发送失败");
    }
    
    
}

- (void)onGetDistrictResult:(BMKDistrictSearch *)searcher result:(BMKDistrictResult *)result errorCode:(BMKSearchErrorCode)error {
    
    [MZEngineAbout sharedInstance].districtSearchBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //code
    }
}

#pragma mark - poi详情短串分享
- (void)startPoiDetailShareOptionWithUid:(NSString *)uid
                     WithCompletionBlock:(MZPoiDetailShareURLBlock)poiDetailShareURLBlock
{
    
    [MZEngineAbout sharedInstance].poiDetailShareURLBlock = poiDetailShareURLBlock;
    
    //发起短串搜索获取poi分享url
    [MZEngineAbout sharedInstance].poiDetailShareOption.uid = uid;
    
    BOOL flag = [[MZEngineAbout sharedInstance].shareURLSearcher requestPoiDetailShareURL:[MZEngineAbout sharedInstance].poiDetailShareOption];
    
    if(flag)
    {
        NSLog(@"详情url检索发送成功");
    }
    else
    {
        NSLog(@"详情url检索发送失败");
    }
    
}

//处理Poi详情分享URL结果
- (void)onGetPoiDetailShareUrlResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error{
    
    [MZEngineAbout sharedInstance].poiDetailShareURLBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 发起位置信息分享
- (void)startLocationShareURLOptionWithSnippet:(NSString *)snippet
                                      withName:(NSString *)name
                                  withLocation:(CLLocationCoordinate2D)location
                           WithCompletionBlock:(MZLocationShareURLBlock)locationShareURLBlock
{
    
    [MZEngineAbout sharedInstance].locationShareURLBlock = locationShareURLBlock;
    
    //发起位置信息分享URL检索
    [MZEngineAbout sharedInstance].locationShareURLOption.snippet = snippet;
    [MZEngineAbout sharedInstance].locationShareURLOption.name = name;
    [MZEngineAbout sharedInstance].locationShareURLOption.location = location;
    BOOL flag = [[MZEngineAbout sharedInstance].shareURLSearcher requestLocationShareURL:[MZEngineAbout sharedInstance].locationShareURLOption];
    
    if(flag)
    {
        NSLog(@"位置信息分享URL检索发送成功");
    }
    else
    {
        NSLog(@"位置信息分享URL发送失败");
    }
    
}

//处理位置信息你分享了URL结果
- (void)onGetLocationShareUrlResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error{
    
    [MZEngineAbout sharedInstance].locationShareURLBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //        在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - “公交/驾车/骑行/步行路线规“的划短串分享
- (void)startRoutePlanShareURLOptionWithStartName:(NSString *)startName
                                  withStartCityID:(NSInteger)startCityID
                                      withEndName:(NSString *)endName
                                    withEndCityID:(NSInteger)endCityID
                                withRoutePlanType:(BMKRoutePlanShareURLType)routePlanType
                                       withCityId:(NSUInteger)cityID
                                   withRouteIndex:(NSInteger)routeIndex
                              WithCompletionBlock:(MZRoutePlanShareURLBlock)routePlanShareURLBlock
{
    
    [MZEngineAbout sharedInstance].routePlanShareURLBlock = routePlanShareURLBlock;
    
    //起点
    [MZEngineAbout sharedInstance].start.name = startName;
    [MZEngineAbout sharedInstance].start.cityID = startCityID;
    [MZEngineAbout sharedInstance].routePlanShareURLOption.from = [MZEngineAbout sharedInstance].start;
    
    //终点
    [MZEngineAbout sharedInstance].end.name = endName;
    [MZEngineAbout sharedInstance].end.cityID = endCityID;
    [MZEngineAbout sharedInstance].routePlanShareURLOption.to = [MZEngineAbout sharedInstance].end;
    
    [MZEngineAbout sharedInstance].routePlanShareURLOption.routePlanType = routePlanType;
    [MZEngineAbout sharedInstance].routePlanShareURLOption.cityID = cityID;//当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
    [MZEngineAbout sharedInstance].routePlanShareURLOption.routeIndex = routeIndex;//公交路线规划短串分享时使用，分享的是第几条线路
    
    //发起检索
    BOOL flag = [[MZEngineAbout sharedInstance].shareURLSearcher requestRoutePlanShareURL:[MZEngineAbout sharedInstance].routePlanShareURLOption];
    
    if (flag) {
        NSLog(@"routePlanShortUrlShare检索发送成功");
    } else {
        NSLog(@"routePlanShortUrlShare检索发送失败");
    }
    
}

- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    
    [MZEngineAbout sharedInstance].routePlanShareURLBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
    }
}



#pragma mark - 获取两点之间的直线距离
+ (float)getLineDistanceBetweenMapPoints:(CLLocationCoordinate2D)startPointLocation
                        endPointLocation:(CLLocationCoordinate2D)endPointLocation{
    BMKMapPoint point1 = BMKMapPointForCoordinate(startPointLocation);
    BMKMapPoint point2 = BMKMapPointForCoordinate(endPointLocation);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return distance;
}

#pragma mark - 传入地图标注数组，确定地图显示范围
+ (void)setMapViewZoomLevelWithAnnotions:(BMKMapView *)mapView
                          annotionsArray:(NSMutableArray *)annotionsArray{
    if (annotionsArray.count == 0) {
        return;
    }
    if (annotionsArray.count <= 1) {
        BMKPointAnnotation * tempAnn = annotionsArray[0];
        [mapView setCenterCoordinate:tempAnn.coordinate animated:NO];
        mapView.zoomLevel = 15;
        return ;
    }
    BMKPointAnnotation * annotion = annotionsArray[0];
    BMKMapPoint pt = BMKMapPointForCoordinate(annotion.coordinate);
    double ltX = pt.x;
    double rbX = pt.x;
    double ltY = pt.y;
    double rbY = pt.y;
    
    for (int i = 1; i<annotionsArray.count; i++) {
        BMKPointAnnotation * tempAnnotion = annotionsArray[i];
        BMKMapPoint tempPt = BMKMapPointForCoordinate(tempAnnotion.coordinate);
        
        if (tempPt.x < ltX) {
            ltX = tempPt.x;
        }
        if (tempPt.x > rbX) {
            rbX = tempPt.x;
        }
        if (tempPt.y > ltY) {
            ltY = tempPt.y;
        }
        if (tempPt.y < rbY) {
            rbY = tempPt.y;
        }
    }
    BMKMapRect rect = BMKMapRectMake(ltX, ltY, rbX - ltX, rbY - ltY);
    mapView.visibleMapRect = rect;
    mapView.zoomLevel = mapView.zoomLevel - 0.3;
    
}

#pragma mark - 根据polyline设置地图范围
+ (void)mapViewFitPolyLine:(BMKMapView *)mapView
                  polyLine:(BMKPolyline *)polyLine{
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [mapView setVisibleMapRect:rect];
    mapView.zoomLevel = mapView.zoomLevel - 0.3;
}

#pragma mark - 隐藏百度地图logo
+ (void)hideMapViewLogoWithMapView:(BMKMapView *)mapView{
    //移除百度地图logo
    for (UIView * tempView in mapView.subviews[0].subviews) {
        if ([tempView isKindOfClass:[UIImageView class]]) {
            [tempView removeFromSuperview];
        }
    }
    
}

#pragma mark - 判断当前定位服务是否开启
+ (BOOL)currentLocationServiceIsAvailable{
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}



#pragma mark - <<<<<<<<<<<<<<<<<<<< 百度导航 >>>>>>>>>>>>>>>>>>>>>>
+ (void)startBNNavServices:(NSString *)appKey{
    //初始化导航SDK
    [BNCoreServices_Instance initServices:appKey];
    [BNCoreServices_Instance startServicesAsyn:^{
        NSLog(@"导航启动成功");
    } fail:^{
        NSLog(@"导航启动失败");
    }];
}

//发起导航
- (void)startNavFrom:(CLLocationCoordinate2D)startLocation to:(CLLocationCoordinate2D)endLocation
{
    [[MZEngineAbout sharedInstance].nodesArray removeAllObjects];
    //起点
    [MZEngineAbout sharedInstance].startNode.pos   = [MZEngineAbout sharedInstance].startPosition;
    [MZEngineAbout sharedInstance].startNode.pos.x     = startLocation.latitude;
    [MZEngineAbout sharedInstance].startNode.pos.y     = startLocation.longitude;
    [MZEngineAbout sharedInstance].startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    //终点
    [MZEngineAbout sharedInstance].endNode.pos     = [MZEngineAbout sharedInstance].endPosition;
    [MZEngineAbout sharedInstance].endNode.pos.x       = endLocation.latitude;
    [MZEngineAbout sharedInstance].endNode.pos.y       = endLocation.longitude;
    [MZEngineAbout sharedInstance].endNode.pos.eType   = BNCoordinate_BaiduMapSDK;
    //发起路径规划
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:[MZEngineAbout sharedInstance].nodesArray time:nil delegete:self userInfo:nil];
}

#pragma mark - BNNaviRoutePlanDelegate
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    if ([[BNCoreServices GetInstance] isServicesInited]) {
        [BNCoreServices_UI showNaviUI: BN_NaviTypeReal delegete:self isNeedLandscape:YES];
    }else{
        NSLog(@"百度导航引擎初始化失败");
    }
}

- (void)setDayNightType:(BNDayNight_CFG_Type)dayNightType{
    dayNightType = BNDayNight_CFG_Type_Day;
}

- (void)setSpeakMode:(BN_Speak_Mode_Enum)speakMode{
    speakMode = BN_Speak_Mode_High;
}

- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    [[[MZEngineAbout sharedInstance] locationService] stopUserLocationService];
    if ([error code] == BNRoutePlanError_LocationFailed) {
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_LocationServiceClosed)
    {
        NSLog(@"定位服务未开启");
    }
}

-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}

-(void)onExitNaviUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
    [[[MZEngineAbout sharedInstance] locationService] stopUserLocationService];
    [[BNCoreServices GetInstance] stopServices];
}

- (void)onExitDeclarationUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
    [[[MZEngineAbout sharedInstance] locationService] stopUserLocationService];
    [[BNCoreServices GetInstance] stopServices];
}



#pragma mark - <<<<<<<<<<<<<<<<<<<< 离线地图（下载，更新，暂停，移除） >>>>>>>>>>>>>>>>>>>>>>
- (void)startDownloadOfflineMapWithCityID:(int)cityID
                      withCompletionBlock:(MZOfflineMapDownloadBlock)offlineMapDownloadBlock{
    BOOL success =[[MZEngineAbout sharedInstance].offlineMap start:cityID];
    if (success) {
        [MZEngineAbout sharedInstance].offlineMapDownloadBlock = offlineMapDownloadBlock;
    }else{
        [MZEngineAbout sharedInstance].offlineMapDownloadBlock = nil;
    }
}
- (void)startUpdateOfflineMapWithCityID:(int)cityID
                    withCompletionBlock:(MZOfflineMapDownloadBlock)offlineMapDownloadBlock{
    BOOL success = [[MZEngineAbout sharedInstance].offlineMap update:cityID];
    if (success) {
        [MZEngineAbout sharedInstance].offlineMapDownloadBlock = offlineMapDownloadBlock;
    }else{
        [MZEngineAbout sharedInstance].offlineMapDownloadBlock = nil;
    }
}
- (BOOL)startPauseOfflineMapWithCityID:(int)cityID{
    return [[MZEngineAbout sharedInstance].offlineMap pause:cityID];
}
- (BOOL)startRemoveOfflineMapWithCityID:(int)cityID{
    return [[MZEngineAbout sharedInstance].offlineMap remove:cityID];
}

+ (NSArray*)getHotCityList{
    return [[MZEngineAbout sharedInstance].offlineMap getHotCityList];
}

+ (NSArray*)getOfflineCityList{
    return [[MZEngineAbout sharedInstance].offlineMap getOfflineCityList];
}

+ (NSArray*)searchCity:(NSString*)cityName{
    return [[MZEngineAbout sharedInstance].offlineMap searchCity:cityName];
}

+ (NSArray*)getAllUpdateInfo{
    return [[MZEngineAbout sharedInstance].offlineMap getAllUpdateInfo];
}

+ (BMKOLUpdateElement*)getUpdateInfo:(int)cityID{
    return [[MZEngineAbout sharedInstance].offlineMap getUpdateInfo:cityID];
}

//离线地图代理，及时更新下载状态
- (void)onGetOfflineMapState:(int)type withState:(int)state{
    BMKOLUpdateElement *updateInfo;
    if (type == TYPE_OFFLINE_UPDATE) {
        updateInfo = [MZBMKMapViewUtil getUpdateInfo:state];
        if (updateInfo) {
            [MZEngineAbout sharedInstance].offlineMapDownloadBlock(type,state,updateInfo);
        }
    }
}

@end
