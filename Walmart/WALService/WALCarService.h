//
//  WALCarService.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WALStatusCount.h"
#import "WALCarDetail.h"
#import "WALCarTrack.h"
#import "WALCarPlayTrack.h"
#import "WALCar.h"

typedef NS_ENUM(NSInteger, WALSearchTimeType) {
    WALSearchTimeTypeToday,
    WALSearchTimeTypeYesterday,
    WALSearchTimeTypeThreeday,
};

@interface WALCarService : NSObject

- (void)resetCarListOffset;
- (void)loadCarListWithType:(NSInteger)type
                 completion:(void (^)(BOOL success, BOOL hasMore, NSArray *carsArray, WALStatusCount *statusCount, NSString *message))completion;
- (void)loadAreaCarListWithType:(NSInteger)type
                         areaID:(NSString *)areaID
                     completion:(void (^)(BOOL success, BOOL hasMore, NSArray *carsArray, WALStatusCount *statusCount, NSString *message))completion;
- (void)loadCarDetailWithVehicleID:(NSString *)vehicleID
                        completion:(void (^)(BOOL success, WALCarDetail *carDetail, NSString *message))completion;
- (void)loadSimpleCarList:(void (^)(BOOL success, NSArray *simpleCarList, NSString *message))completion;
- (void)loadCarTrackListWithVehicleID:(NSString *)vehicleID
                            startTime:(NSString *)startTime
                              endTime:(NSString *)endTime
                           completion:(void (^)(BOOL success, WALCarTrack *carTrack, NSString *message))completion;
- (void)loadCarPlayTrackListWithVehicleID:(NSString *)vehicleID
                                startTime:(NSString *)startTime
                                  endTime:(NSString *)endTime
                               completion:(void (^)(BOOL success, WALCarPlayTrack *carPlayTrack, NSString *message))completion;
- (void)loadMapMonitWithVehicleID:(NSString *)vehicleID
                       completion:(void (^)(BOOL success, WALCar *car, NSString *message))completion;
- (void)loadPlaceNameWithVehicleID:(NSString *)vehicleID
                              lon:(NSString *)lon
                              lat:(NSString *)lat
                       completion:(void (^)(BOOL success, NSString *placeName, NSString *message))completion;
- (void)loadAreaList:(void (^)(BOOL success, NSArray *areaArray, NSString *message))completion;
- (void)loadCarListWithAreaName:(NSString *)areaName
                     completion:(void (^)(BOOL success, NSArray *areaArray, NSString *message))completion;

@end
