//
//  MZBMKMapViewUtil.m
//  HuiSongHuo-Owner
//
//  Created by liminzhou on 16/3/8.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "MZBMKMapViewUtil.h"

@implementation MZBMKMapViewUtil
{
    ///用于接收定位服务对象
    BMKLocationService * _locationService;
}
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

#pragma mark - 开始定位服务

- (void)startLocationWithBMKLocationService:(BMKLocationService *)locationService WithCompletionBlock:(MZLocationBlock)locationBlock {
    self.locationBlock = locationBlock;
    /** 启动LocationService */
    _locationService = locationService;
    [locationService startUserLocationService];
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    //NSLog(@"heading is %@",userLocation.heading);
    self.locationBlock(userLocation);
    [_locationService stopUserLocationService];
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    self.locationBlock(userLocation);
    [_locationService stopUserLocationService];
    
}

#pragma mark - 开始正向地理编码（根据位置信息获取经纬度）

//开始正向地理编码
- (void)startGeoCodeWithAddressWithBMKGeoCodeSearchOption:(BMKGeoCodeSearchOption *)geoCodeSearchOption
                                     withBMKGeoCodeSearch:(BMKGeoCodeSearch *)searcher
                                              withAddress:(NSString *)address
                                                  andCity:(NSString *)city
                                       andCompletionBlock:(MZGeoCodeBlock)geoCodeBlock
{
    self.geoCodeBlock = geoCodeBlock;
    
    geoCodeSearchOption.address = address;
    geoCodeSearchOption.city = city;
    BOOL flag = [searcher geoCode:geoCodeSearchOption];
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
    
    self.geoCodeBlock(result,error);
    
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
                withBMKReverseGeoCodeOption:(BMKReverseGeoCodeOption *)reverseGeoCodeSearchOption
                       withBMKGeoCodeSearch:(BMKGeoCodeSearch *)searcher
                         andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock
{
    self.reverseGeoCodeBlock = reverseGeoCodeBlock;
    NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [searcher reverseGeoCode:reverseGeoCodeSearchOption];
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
                  withBMKReverseGeoCodeOption:(BMKReverseGeoCodeOption *)reverseGeoCodeSearchOption
                         withBMKGeoCodeSearch:(BMKGeoCodeSearch *)searcher
                           andCompletionBlock:(MZReverseGeoCodeBlock)reverseGeoCodeBlock
{
    
    self.reverseGeoCodeBlock = reverseGeoCodeBlock;
    
    reverseGeoCodeSearchOption.reverseGeoPoint = searchLocation;
    BOOL flag = [searcher reverseGeoCode:reverseGeoCodeSearchOption];
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
    
    self.reverseGeoCodeBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 开始POI检索（城市内、周边、矩形）
// 开始城市内POI检索

- (void)startPoiSearchWithBMKCitySearchOption:(BMKCitySearchOption *)citySearchOption
                             withBMKPoiSearch:(BMKPoiSearch *)poisearch
                                withPageIndex:(int)pageIndex
                                 pageCapacity:(int)pageCapacity
                                         city:(NSString *)city
                                      keyword:(NSString *)keyword
                          WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock
{
    
    self.poiSearchBlock = poiSearchBlock;
    //POI检索
    citySearchOption.pageIndex = pageIndex;
    citySearchOption.pageCapacity = pageCapacity;
    citySearchOption.city = city;
    citySearchOption.keyword = keyword;
    BOOL flag = [poisearch poiSearchInCity:citySearchOption];
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
- (void)startPoiSearchWithBMKNearbySearchOption:(BMKNearbySearchOption *)nearbySearchOption
                               withBMKPoiSearch:(BMKPoiSearch *)poisearch
                                  withPageIndex:(int)pageIndex
                                   pageCapacity:(int)pageCapacity
                                        keyword:(NSString *)keyword
                                       location:(CLLocationCoordinate2D)location
                                         radius:(int)radius
                                       sortType:(BMKPoiSortType)sortType
                            WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock
{
    
    self.poiSearchBlock = poiSearchBlock;
    
    nearbySearchOption.pageIndex = pageIndex;
    nearbySearchOption.pageCapacity = pageCapacity;
    nearbySearchOption.keyword = keyword;
    nearbySearchOption.location = location;
    nearbySearchOption.radius = radius;
    nearbySearchOption.sortType = sortType;
    
    BOOL flag = [poisearch poiSearchNearBy:nearbySearchOption];
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
- (void)startPoiSearchWithBMKBoundSearchOption:(BMKBoundSearchOption *)boundSearchOption
                              withBMKPoiSearch:(BMKPoiSearch *)poisearch
                                 withPageIndex:(int)pageIndex
                                  pageCapacity:(int)pageCapacity
                                       keyword:(NSString *)keyword
                                    leftBottom:(CLLocationCoordinate2D)leftBottom
                                      rightTop:(CLLocationCoordinate2D)rightTop
                           WithCompletionBlock:(MZPoiSearchBlock)poiSearchBlock
{
    
    self.poiSearchBlock = poiSearchBlock;
    
    boundSearchOption.pageIndex = pageIndex;
    boundSearchOption.pageCapacity = pageCapacity;
    boundSearchOption.keyword = keyword;
    boundSearchOption.leftBottom = leftBottom;
    boundSearchOption.rightTop = rightTop;
    
    BOOL flag = [poisearch poiSearchInbounds:boundSearchOption];
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
    
    self.poiSearchBlock(result,error);
    
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
- (void)startKeywordSearchOfLenoveWithBMKSuggestionSearchOption:(BMKSuggestionSearchOption *)suggestionSearchOption
                                        withBMKSuggestionSearch:(BMKSuggestionSearch *)suggestSearcher
                                                   withCityName:(NSString *)cityName
                                                    withKeyword:(NSString *)keyword
                                            WithCompletionBlock:(MZKeyordLenoveSearchBlock)keywordLenoveSearchBlock

{
    
    self.keywordLenoveSearchBlock = keywordLenoveSearchBlock;
    //关键字联想代码
    suggestionSearchOption.cityname = cityName;
    suggestionSearchOption.keyword  = keyword;
    BOOL flag = [suggestSearcher suggestionSearch:suggestionSearchOption];
    
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
    
    self.keywordLenoveSearchBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
    
}

#pragma mark - 开始路径规划（驾车、公交、步行）
//开始路径规划（驾车）
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
                                   WithCompletionBlock:(MZPlanDrivingPathBlock)planPathBlock

{
    
    self.planDrivingPathBlock = planPathBlock;
    
    start.name = startName;
    start.cityName = startCityName;
    start.pt = startLocation;
    end.name = endName;
    end.cityName = endCityName;
    end.pt = EndLocation;
    
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    transitRouteSearchOption.drivingPolicy = drivingPolicy;
    
    BOOL flag = [searcher drivingSearch:transitRouteSearchOption];
    
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
    self.planDrivingPathBlock(result,error);
    
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
                                   WithCompletionBlock:(MZPlanTransitPathBlock)planPathBlock
{
    
    
    self.planTransitPathBlock = planPathBlock;
    
    start.name = startName;
    start.cityName = startCityName;
    start.pt = startLocation;
    end.name = endName;
    end.cityName = endCityName;
    end.pt = EndLocation;
    
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    transitRouteSearchOption.city = city;
    transitRouteSearchOption.transitPolicy = transitPolicy;
    
    BOOL flag = [searcher transitSearch:transitRouteSearchOption];
    
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
    
    self.planTransitPathBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
    }else{
        
    }
}


//开始路径规划（步行）
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
                                   WithCompletionBlock:(MZPlanWalkingPathBlock)planPathBlock
{
    
    self.planWalkingPathBlock = planPathBlock;
    
    start.name = startName;
    start.cityName = startCityName;
    start.pt = startLocation;
    end.name = endName;
    end.cityName = endCityName;
    end.pt = EndLocation;
    
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    
    BOOL flag = [searcher walkingSearch:transitRouteSearchOption];
    
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
    
    self.planWalkingPathBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
    }else{
        
    }
}

#pragma mark - 开始POI详情检索
- (void)startPoiDetailSearchWithBMKPoiDetailSearchOption:(BMKPoiDetailSearchOption *)poiDetailSearchOption
                                      WithBMKRouteSearch:(BMKPoiSearch *)searcher
                                              withPoiUid:(NSString *)poiUid
                                     WithCompletionBlock:(MZPoiDetailSearchBlock)poiDetailSearchBlock{
    
    self.poiDetailSearchBlock = poiDetailSearchBlock;
    
    poiDetailSearchOption.poiUid = poiUid;
    
    BOOL flag = [searcher poiDetailSearch:poiDetailSearchOption];
    
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
    
    self.poiDetailSearchBlock(poiDetailResult,errorCode);
    
    if(errorCode == BMK_SEARCH_NO_ERROR){
        //在此处理正常结果
    }
}


#pragma mark - 公交详情信息检索
- (void)startBusDetailSearchWithBMKBusLineSearchOption:(BMKBusLineSearchOption *)busDetailSearchOption
                                    WithBMKRouteSearch:(BMKBusLineSearch *)searcher
                                        withBusLineUid:(NSString *)busLineUid
                                              withCity:(NSString *)city
                                   WithCompletionBlock:(MZBusLineDetailSearchBlock)busLineDetailSearchBlock
{
    
    self.busLineDetailSearchBlock = busLineDetailSearchBlock;
    
    
    busDetailSearchOption.busLineUid = busLineUid;
    busDetailSearchOption.city = city;
    
    BOOL flag = [searcher busLineSearch:busDetailSearchOption];
    
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
    
    self.busLineDetailSearchBlock(busLineResult,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 行政区边界数据检索
- (void)startDistrictSearchWithBMKDistrictSearchOption:(BMKDistrictSearchOption *)districtSearchOption
                                    WithBMKRouteSearch:(BMKDistrictSearch *)searcher
                                              withCity:(NSString *)city
                                          withDistrict:(NSString *)district
                                   WithCompletionBlock:(MZDistrictSearchBlock)districtSearchBlock
{
    
    self.districtSearchBlock = districtSearchBlock;
    
    districtSearchOption.city = city;
    districtSearchOption.district = district;
    
    //发起检索
    BOOL flag = [searcher districtSearch:districtSearchOption];
    
    if (flag) {
        NSLog(@"district检索发送成功");
    } else {
        NSLog(@"district检索发送失败");
    }
    
    
}

- (void)onGetDistrictResult:(BMKDistrictSearch *)searcher result:(BMKDistrictResult *)result errorCode:(BMKSearchErrorCode)error {
    
    self.districtSearchBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //code
    }
}

#pragma mark - poi详情短串分享
- (void)startPoiDetailShareOptionWithBMKPoiDetailShareURLOption:(BMKPoiDetailShareURLOption *)poiDetailShareOption
                                             WithBMKRouteSearch:(BMKShareURLSearch *)searcher
                                                        withUid:(NSString *)uid
                                            WithCompletionBlock:(MZPoiDetailShareURLBlock)poiDetailShareURLBlock
{
    
    self.poiDetailShareURLBlock = poiDetailShareURLBlock;
    
    //发起短串搜索获取poi分享url
    poiDetailShareOption.uid = uid;
    
    BOOL flag = [searcher requestPoiDetailShareURL:poiDetailShareOption];
    
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
    
    self.poiDetailShareURLBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 发起位置信息分享
- (void)startLocationShareURLOptionWithBMKPoiDetailShareURLOption:(BMKLocationShareURLOption *)locationShareURLOption
                                               WithBMKRouteSearch:(BMKShareURLSearch *)searcher
                                                      withSnippet:(NSString *)snippet
                                                         withName:(NSString *)name
                                                     withLocation:(CLLocationCoordinate2D)location
                                              WithCompletionBlock:(MZLocationShareURLBlock)locationShareURLBlock
{
    
    self.locationShareURLBlock = locationShareURLBlock;
    
    //发起位置信息分享URL检索
    locationShareURLOption.snippet = snippet;
    locationShareURLOption.name = name;
    locationShareURLOption.location = location;
    BOOL flag = [searcher requestLocationShareURL:locationShareURLOption];
    
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
    
    self.locationShareURLBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {
//        在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - “公交/驾车/骑行/步行路线规“的划短串分享
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
                                              WithCompletionBlock:(MZRoutePlanShareURLBlock)routePlanShareURLBlock
{
    
    self.routePlanShareURLBlock = routePlanShareURLBlock;
    
    //起点
    start.name = startName;
    start.cityID = startCityID;
    routePlanShareURLOption.from = start;
    
    //终点
    end.name = endName;
    end.cityID = endCityID;
    routePlanShareURLOption.to = end;
    
    routePlanShareURLOption.routePlanType = routePlanType;
    routePlanShareURLOption.cityID = cityID;//当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
    routePlanShareURLOption.routeIndex = routeIndex;//公交路线规划短串分享时使用，分享的是第几条线路
    
    //发起检索
    BOOL flag = [searcher requestRoutePlanShareURL:routePlanShareURLOption];
    
    if (flag) {
        NSLog(@"routePlanShortUrlShare检索发送成功");
    } else {
        NSLog(@"routePlanShortUrlShare检索发送失败");
    }
    
}

- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {

    self.routePlanShareURLBlock(result,error);
    
    if (error == BMK_SEARCH_NO_ERROR) {

    }
}



#pragma mark - 获取两点之间的直线距离
- (float)getLineDistanceBetweenMapPoints:(CLLocationCoordinate2D)startPointLocation
                        endPointLocation:(CLLocationCoordinate2D)endPointLocation{
    BMKMapPoint point1 = BMKMapPointForCoordinate(startPointLocation);
    BMKMapPoint point2 = BMKMapPointForCoordinate(endPointLocation);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return distance;
}

#pragma mark - 传入地图标注数组，确定地图显示范围
- (void)setMapViewZoomLevelWithAnnotions:(BMKMapView *)mapView
                          annotionsArray:(NSMutableArray *)annotionsArray{
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
- (void)mapViewFitPolyLine:(BMKMapView *)mapView
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
- (void)hideMapViewLogoWithMapView:(BMKMapView *)mapView{
    //移除百度地图logo
    for (UIView * tempView in mapView.subviews[0].subviews) {
        if ([tempView isKindOfClass:[UIImageView class]]) {
            [tempView removeFromSuperview];
        }
    }

}

#pragma mark - 判断当前定位服务是否开启
- (BOOL)currentLocationServiceIsAvailable{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

@end
