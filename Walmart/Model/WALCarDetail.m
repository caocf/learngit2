//
//  WALCarDetail.m
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarDetail.h"

@implementation WALCarDetail

+ (WALCarDetail *)carDetailWithDictionary:(NSDictionary *)dictionary
{
    WALCarDetail *car = [[WALCarDetail alloc] init];
    car.aInfo = [dictionary strValue:@"AInfo"];
    car.load = [dictionary strValue:@"ApprovedLoad"];
    car.telPhone = [dictionary strValue:@"CellPhone"];
    car.dataSource = [dictionary strValue:@"DataSource"];
    car.driver = [dictionary strValue:@"Driver"];
    car.eInfo = [dictionary strValue:@"EInfo"];
    car.GPSTime = [dictionary strValue:@"GPSTime"];
    car.insideLength = [dictionary strValue:@"InsideLength"];
    car.milleage = [dictionary strValue:@"Odometer"];
    car.oil = [dictionary strValue:@"Oil"];
    car.overallLength = [dictionary strValue:@"OverallLength"];
    car.placeName = [dictionary strValue:@"PlaceName"];
    car.pointInfo = [dictionary strValue:@"PointInfo"];
    car.regName = [dictionary strValue:@"RegName"];
    car.roadName = [dictionary strValue:@"RoadName"];
    car.speed = [dictionary strValue:@"Speed"];
    car.T1 = [dictionary strValue:@"T1"];
    car.T2 = [dictionary strValue:@"T2"];
    car.T3 = [dictionary strValue:@"T3"];
    car.T4 = [dictionary strValue:@"T4"];
    car.typeName = [dictionary strValue:@"TypeName"];
    car.carStatus = [dictionary strValue:@"VStatus"];
    car.vehicleAppType = [dictionary strValue:@"VehicleAppType"];
    car.vehicleID = [dictionary strValue:@"VehicleID"];
    car.vehicleType = [dictionary strValue:@"VehicleType"];
    return car;
}

@end
