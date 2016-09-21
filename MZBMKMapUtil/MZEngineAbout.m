
//
//  MZEngineAbout.m
//  DHETC
//
//  Created by liminzhou on 16/9/19.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "MZEngineAbout.h"

@implementation MZEngineAbout

+ (MZEngineAbout*)sharedInstance
{
    static MZEngineAbout *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MZEngineAbout alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark  ---------------------------------百度地图---------------------------------
#pragma mark - getter
/************************************************* 定位与编码 *************************************************/
- (BMKLocationService *)locationService{
    if (!_locationService) {
        _locationService            = [[BMKLocationService alloc] init];
    }
    return _locationService;
}
- (BMKGeoCodeSearchOption *)geoCodeSearchOption{
    if (!_geoCodeSearchOption) {
        _geoCodeSearchOption        = [[BMKGeoCodeSearchOption alloc] init];
    }
    return _geoCodeSearchOption;
}
- (BMKGeoCodeSearch *)geoCodeSearch{
    if (!_geoCodeSearch) {
        _geoCodeSearch              = [[BMKGeoCodeSearch alloc] init];
    }
    return _geoCodeSearch;
}
- (BMKReverseGeoCodeOption *)reverseGeoCodeSearchOption{
    if (!_reverseGeoCodeSearchOption) {
        _reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    }
    return _reverseGeoCodeSearchOption;
}
/************************************************* poi检索 *************************************************/
- (BMKPoiSearch *)poiSearch{
    if (!_poiSearch) {
        _poiSearch                  = [[BMKPoiSearch alloc] init];
    }
    return _poiSearch;
}
- (BMKCitySearchOption *)citySearchOption{
    if (!_citySearchOption) {
        _citySearchOption           = [[BMKCitySearchOption alloc] init];
    }
    return _citySearchOption;
}
- (BMKNearbySearchOption *)nearbySearchOption{
    if (!_nearbySearchOption) {
        _nearbySearchOption         = [[BMKNearbySearchOption alloc] init];
    }
    return _nearbySearchOption;
}
- (BMKBoundSearchOption *)boundSearchOption{
    if (!_boundSearchOption) {
        _boundSearchOption          = [[BMKBoundSearchOption alloc] init];
    }
    return _boundSearchOption;
}
- (BMKPoiDetailSearchOption *)poiDetailSearchOption{
    if (!_poiDetailSearchOption) {
        _poiDetailSearchOption      = [[BMKPoiDetailSearchOption alloc] init];
    }
    return _poiDetailSearchOption;
}

/************************************************* 关键字检索 *************************************************/
- (BMKSuggestionSearchOption *)suggestSearchOption{
    if (!_suggestSearchOption) {
        _suggestSearchOption        = [[BMKSuggestionSearchOption alloc] init];
    }
    return _suggestSearchOption;
}
- (BMKSuggestionSearch *)suggestSearch{
    if (!_suggestSearch) {
        _suggestSearch              = [[BMKSuggestionSearch alloc] init];
    }
    return _suggestSearch;
}

/************************************************* 路径规划 *************************************************/
- (BMKRouteSearch *)routeSearcher{
    if (!_routeSearcher) {
        _routeSearcher              = [[BMKRouteSearch alloc] init];
    }
    return _routeSearcher;
}
- (BMKPlanNode *)start{
    if (!_start) {
        _start                      = [[BMKPlanNode alloc] init];
    }
    return _start;
}
- (BMKPlanNode *)end{
    if (!_end) {
        _end                        = [[BMKPlanNode alloc] init];
    }
    return _end;
}
- (BMKDrivingRoutePlanOption *)drivingRouteSearchOption{
    if (!_drivingRouteSearchOption) {
        _drivingRouteSearchOption   = [[BMKDrivingRoutePlanOption alloc] init];
    }
    return _drivingRouteSearchOption;
}
- (BMKTransitRoutePlanOption *)transitRouteSearchOption{
    if (!_transitRouteSearchOption) {
        _transitRouteSearchOption   = [[BMKTransitRoutePlanOption alloc] init];
    }
    return _transitRouteSearchOption;
}
- (BMKWalkingRoutePlanOption *)walkingRouteSearchOption{
    if (!_walkingRouteSearchOption) {
        _walkingRouteSearchOption   = [[BMKWalkingRoutePlanOption alloc] init];
    }
    return _walkingRouteSearchOption;
}

/************************************************* 线路区域检索 *************************************************/
- (BMKBusLineSearchOption *)busDetailSearchOption{
    if (!_busDetailSearchOption) {
        _busDetailSearchOption      = [[BMKBusLineSearchOption alloc] init];
    }
    return _busDetailSearchOption;
}
- (BMKBusLineSearch *)busLineSearcher{
    if (!_busLineSearcher) {
        _busLineSearcher            = [[BMKBusLineSearch alloc] init];
    }
    return _busLineSearcher;
}
- (BMKDistrictSearchOption *)districtSearchOption{
    if (!_districtSearchOption) {
        _districtSearchOption       = [[BMKDistrictSearchOption alloc] init];
    }
    return _districtSearchOption;
}
- (BMKDistrictSearch *)districtSearcher{
    if (!_districtSearcher) {
        _districtSearcher           = [[BMKDistrictSearch alloc] init];
    }
    return _districtSearcher;
}
/************************************************* 短串分享 *************************************************/
- (BMKShareURLSearch *)shareURLSearcher{
    if (!_shareURLSearcher) {
        _shareURLSearcher           = [[BMKShareURLSearch alloc] init];
    }
    return _shareURLSearcher;
}
- (BMKPoiDetailShareURLOption *)poiDetailShareOption{
    if (!_poiDetailShareOption) {
        _poiDetailShareOption       = [[BMKPoiDetailShareURLOption alloc] init];
    }
    return _poiDetailShareOption;
}
- (BMKLocationShareURLOption *)locationShareURLOption{
    if (!_locationShareURLOption) {
        _locationShareURLOption     = [[BMKLocationShareURLOption alloc] init];
    }
    return _locationShareURLOption;
}
- (BMKRoutePlanShareURLOption *)routePlanShareURLOption{
    if (!_routePlanShareURLOption) {
        _routePlanShareURLOption    = [[BMKRoutePlanShareURLOption alloc] init];
    }
    return _routePlanShareURLOption;
}

#pragma mark - addEngineDelegate
- (void)addLocationServiceDelegate{
    if (self.locationService) {
        if (!_locationService.delegate) {
            _locationService.delegate  = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addGeoCodeSearchDelegate{
    if (self.geoCodeSearch) {
        if (!_geoCodeSearch.delegate) {
            _geoCodeSearch.delegate    = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addPoiSearchDelegate{
    if (self.poiSearch) {
        if (!_poiSearch.delegate) {
            _poiSearch.delegate        = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addSuggestSearchDelegate{
    if (self.suggestSearch) {
        if (!_suggestSearch.delegate) {
            _suggestSearch.delegate    = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addRouteSearcherDelegate{
    if (self.routeSearcher) {
        if (!_routeSearcher.delegate) {
            _routeSearcher.delegate    = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addBusLineSearcherDelegate{
    if (self.busLineSearcher) {
        if (!_busLineSearcher.delegate) {
            _busLineSearcher.delegate  = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addDistrictSearcherDelegate{
    if (self.districtSearcher) {
        if (!_districtSearcher.delegate) {
            _districtSearcher.delegate = [MZBMKMapViewUtil sharedInstance];
        }
    }
}
- (void)addShareURLSearcherDelegate{
    if (self.shareURLSearcher) {
        if (!_shareURLSearcher.delegate) {
            _shareURLSearcher.delegate = [MZBMKMapViewUtil sharedInstance];
        }
    }
}

#pragma mark - removeEngineDelegate
- (void)removeEngineDelegate{
    if (_locationService) {
        _locationService.delegate  = nil;
    }
    if (_geoCodeSearch) {
        _geoCodeSearch.delegate    = nil;
    }
    if (_poiSearch) {
        _poiSearch.delegate        = nil;
    }
    if (_suggestSearch) {
        _suggestSearch.delegate    = nil;
    }
    if (_routeSearcher) {
        _routeSearcher.delegate    = nil;
    }
    if (_busLineSearcher) {
        _busLineSearcher.delegate  = nil;
    }
    if (_districtSearcher) {
        _districtSearcher.delegate = nil;
    }
    if (_shareURLSearcher) {
        _shareURLSearcher.delegate = nil;
    }
    
}

#pragma mark - removeEngine
- (void)removeEngine{
    if (_locationService) {
        _locationService            = nil;
    }
    if (_reverseGeoCodeSearchOption) {
        _reverseGeoCodeSearchOption = nil;
    }
    if (_geoCodeSearchOption) {
        _geoCodeSearchOption        = nil;
    }
    if (_geoCodeSearch) {
        _geoCodeSearch              = nil;
    }
    if (_routeSearcher) {
        _routeSearcher              = nil;
    }
    if (_start) {
        _start                      = nil;
    }
    if (_end) {
        _end                        = nil;
    }
    if (_drivingRouteSearchOption) {
        _drivingRouteSearchOption   = nil;
    }
    if (_transitRouteSearchOption) {
        _transitRouteSearchOption   = nil;
    }
    if (_walkingRouteSearchOption) {
        _walkingRouteSearchOption   = nil;
    }
    if (_poiSearch) {
        _poiSearch                  = nil;
    }
    if (_citySearchOption) {
        _citySearchOption           = nil;
    }
    if (_nearbySearchOption) {
        _nearbySearchOption         = nil;
    }
    if (_boundSearchOption) {
        _boundSearchOption          = nil;
    }
    if (_poiDetailSearchOption) {
        _poiDetailSearchOption      = nil;
    }
    if (_busDetailSearchOption) {
        _busDetailSearchOption      = nil;
    }
    if (_busLineSearcher) {
        _busLineSearcher            = nil;
    }
    if (_districtSearchOption) {
        _districtSearchOption       = nil;
    }
    if (_districtSearcher) {
        _districtSearcher           = nil;
    }
    if (_shareURLSearcher) {
        _shareURLSearcher           = nil;
    }
    if (_poiDetailShareOption) {
        _poiDetailShareOption       = nil;
    }
    if (_locationShareURLOption) {
        _locationShareURLOption     = nil;
    }
    if (_routePlanShareURLOption) {
        _routePlanShareURLOption    = nil;
    }
    if (_suggestSearchOption) {
        _suggestSearchOption        = nil;
    }
    if (_suggestSearch) {
        _suggestSearch              = nil;
    }
    
}

#pragma mark  ---------------------------------百度导航---------------------------------
#pragma mark - getter
- (BNRoutePlanNode *)startNode{
    if (!_startNode) {
        _startNode = [[BNRoutePlanNode alloc] init];
    }
    return _startNode;
}
- (BNRoutePlanNode *)endNode{
    if (!_endNode) {
        _endNode = [[BNRoutePlanNode alloc] init];
    }
    return _endNode;
}
- (NSMutableArray *)nodesArray{
    if (!_nodesArray) {
        _nodesArray = [[NSMutableArray alloc] initWithCapacity:2];
    }
    [_nodesArray addObject:self.startNode];
    [_nodesArray addObject:self.endNode];
    return _nodesArray;
}
- (BNPosition *)startPosition{
    if (!_startPosition) {
        _startPosition = [[BNPosition alloc] init];
    }
    return _startPosition;
}
- (BNPosition *)endPosition{
    if (!_endPosition) {
        _endPosition = [[BNPosition alloc] init];
    }
    return _endPosition;
}



@end
