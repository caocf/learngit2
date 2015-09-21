//
//  WALCarStopPosition.m
//  Walmart
//
//  Created by wangxu on 15/9/21.
//  Copyright © 2015年 e6. All rights reserved.
//

#import "WALCarStopPosition.h"

@implementation WALCarStopPosition

+ (WALCarStopPosition *)carStopPositionWithDictionary:(NSDictionary *)dictionary
{
    WALCarStopPosition *carStopPosition = [[WALCarStopPosition alloc] init];
    carStopPosition.areaName = [dictionary strValue:@"AreaName"];
    carStopPosition.stopTime = [dictionary strValue:@"BTime"];
    carStopPosition.currentOdometer = [dictionary strValue:@"CurOdom"];
    carStopPosition.endTime = [dictionary strValue:@"ETime"];
    carStopPosition.lat = [dictionary strValue:@"Lat"];
    carStopPosition.lon = [dictionary strValue:@"Lon"];
    carStopPosition.odometer = [dictionary strValue:@"Odometer"];
    carStopPosition.place = [dictionary strValue:@"Place"];
    carStopPosition.stopSeconds = [dictionary strValue:@"StopSec"];
    return carStopPosition;
}

@end
