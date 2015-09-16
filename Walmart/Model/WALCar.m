//
//  WALCar.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCar.h"

@implementation WALCar

+ (WALCar *)carWithDictionary:(NSDictionary *)dictionary
{
    WALCar *car = [[WALCar alloc] init];
    car.aInfo = [dictionary strValue:@"AInfo"];
    car.direction = [dictionary strValue:@"Direction"];
    car.eInfo = [dictionary strValue:@"EInfo"];
    car.GPSTime = [dictionary strValue:@"GPSTime"];
    car.lat = [dictionary strValue:@"Lat"];
    car.lon = [dictionary strValue:@"Lon"];
    car.placeName = [dictionary strValue:@"PlaceName"];
    car.pointInfo = [dictionary strValue:@"PointInfo"];
    car.regName = [dictionary strValue:@"RegName"];
    car.speed = [dictionary strValue:@"Speed"];
    car.status = [dictionary strValue:@"Status"];
    car.telPhone = [dictionary strValue:@"TelPhone"];
    car.vehicleID = [dictionary strValue:@"VehicleID"];
    return car;
}

@end
