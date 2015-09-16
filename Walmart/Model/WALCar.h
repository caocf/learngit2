//
//  WALCar.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALCar : NSObject

@property (nonatomic, strong) NSString *aInfo;
@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *eInfo;
@property (nonatomic, strong) NSString *GPSTime;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *pointInfo;
@property (nonatomic, strong) NSString *regName;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *telPhone;
@property (nonatomic, strong) NSString *vehicleID;

+ (WALCar *)carWithDictionary:(NSDictionary *)dictionary;

@end
