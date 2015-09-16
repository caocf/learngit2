//
//  WALCarDetail.h
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALCarDetail : NSObject

@property (nonatomic, strong) NSString *aInfo;
@property (nonatomic, strong) NSString *load;
@property (nonatomic, strong) NSString *telPhone;
@property (nonatomic, strong) NSString *dataSource;
@property (nonatomic, strong) NSString *driver;
@property (nonatomic, strong) NSString *eInfo;
@property (nonatomic, strong) NSString *GPSTime;
@property (nonatomic, strong) NSString *insideLength;
@property (nonatomic, strong) NSString *milleage;
@property (nonatomic, strong) NSString *oil;
@property (nonatomic, strong) NSString *overallLength;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *pointInfo;
@property (nonatomic, strong) NSString *regName;
@property (nonatomic, strong) NSString *roadName;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *T1;
@property (nonatomic, strong) NSString *T2;
@property (nonatomic, strong) NSString *T3;
@property (nonatomic, strong) NSString *T4;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *carStatus;
@property (nonatomic, strong) NSString *vehicleAppType;
@property (nonatomic, strong) NSString *vehicleID;
@property (nonatomic, strong) NSString *vehicleType;

+ (WALCarDetail *)carDetailWithDictionary:(NSDictionary *)dictionary;

@end
