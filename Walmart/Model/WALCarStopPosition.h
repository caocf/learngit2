//
//  WALCarStopPosition.h
//  Walmart
//
//  Created by wangxu on 15/9/21.
//  Copyright © 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALCarStopPosition : NSObject

@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *stopSeconds;
@property (nonatomic, strong) NSString *stopTime;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *odometer;
@property (nonatomic, strong) NSString *currentOdometer;

+ (WALCarStopPosition *)carStopPositionWithDictionary:(NSDictionary *)dictionary;

@end
