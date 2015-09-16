//
//  WALSimpleCar.m
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALSimpleCar.h"

@implementation WALSimpleCar

+ (WALSimpleCar *)simpleCarWithDictionary:(NSDictionary *)dictionary;
{
    WALSimpleCar *car = [[WALSimpleCar alloc] init];
    car.DS = [dictionary strValue:@"DS"];
    car.length = [dictionary strValue:@"Length"];
    car.load = [dictionary strValue:@"Load"];
    car.regName = [dictionary strValue:@"RegName"];
    car.TN = [dictionary strValue:@"TN"];
    car.type = [dictionary strValue:@"Type"];
    car.vehicleID = [dictionary strValue:@"VehicleID"];
    return car;
}

@end
