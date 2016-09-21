//
//  ExternalGPSModel.m
//  NaviDemo
//
//  Created by Baidu on 14/12/30.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "ExternalGPSModel.h"
#import "BNLocation.h"
#import "BNCoreServices.h"
#import <CoreLocation/CoreLocation.h>


@interface ExternalGPSModel ()

@property (strong, nonatomic) NSMutableArray* gpsArray;

@property (strong, nonatomic) NSTimer* timer;

@property (assign, nonatomic) int gpsIndex;

@end

@implementation ExternalGPSModel

- (instancetype)init
{
    if (self = [super init])
    {
        _gpsArray = [[NSMutableArray alloc] init];
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    NSString* gpsTestFilePath = [[NSBundle mainBundle] pathForResource:@"gpstest" ofType:@"txt"];
    NSString* gpsText = [NSString stringWithContentsOfFile:gpsTestFilePath encoding:NSUTF8StringEncoding error:NULL];
    NSArray* gpsArray = [gpsText componentsSeparatedByString:@"\r\n"];
    //从gps数据文件中解析出gps信息
    for (NSString* oneGPS in gpsArray)
    {
        NSArray* gpsElements = [oneGPS componentsSeparatedByString:@","];
        if (gpsElements.count > 6)
        {
            //设置gps数据
            BNLocation* oneGPSInfo = [[BNLocation alloc] init];
            double longtitude = [gpsElements[2] doubleValue];
            double latitude = [gpsElements[1] doubleValue];
            double speed = [gpsElements[3] doubleValue];
            double direction = [gpsElements[4] doubleValue];
            double accuracy = [gpsElements[5] doubleValue];
            oneGPSInfo.coordinate = CLLocationCoordinate2DMake(longtitude,latitude);
            oneGPSInfo.speed = speed;
            oneGPSInfo.course = direction;
            oneGPSInfo.horizontalAccuracy = accuracy;
            oneGPSInfo.verticalAccuracy = 0;
            oneGPSInfo.altitude = 256;
            [self.gpsArray addObject:oneGPSInfo];
        }
    }
}

- (void)startPostGPS
{
    if (self.timer) {
        [self stopPostGPS];
    }
    
    self.gpsIndex = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(postGPS) userInfo:nil repeats:YES];
    
    [self.timer fire];
}

- (void)stopPostGPS
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)postGPS
{
    if (!self.gpsArray || self.gpsArray.count == 0 || self.gpsArray.count <= self.gpsIndex) return;
    [BNCoreServices_Location setCurrentLocation:self.gpsArray[self.gpsIndex]];
    self.gpsIndex = (self.gpsIndex + 1)%self.gpsArray.count;
}

@end
