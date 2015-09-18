//
//  WALCarService.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarService.h"
#import "AFHTTPRequestOperationManager.h"
#import "WALSimpleCar.h"
#import "WALArea.h"

static NSInteger kNumberPerPage = 20;

@implementation WALCarService
{
    NSInteger _pageNumber;
}

- (id)init
{
    if (self = [super init]) {
        _pageNumber = 1;
    }
    return self;
}

- (void)resetCarListOffset
{
    _pageNumber = 1;
}

- (void)loadCarListWithType:(NSInteger)type
                 completion:(void (^)(BOOL success, BOOL hasMore, NSArray *carsArray, WALStatusCount *statusCount, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"refresh":@"0",
                                         @"type":[@(type) stringValue],
                                         @"pagesize":[@(kNumberPerPage) stringValue],
                                         @"curpage":[@(_pageNumber) stringValue],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID,
                                         @"version":[NSUserDefaults version]
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Vehicle/GetCarsMonitData", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *carArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"monitArr"]) {
                     [carArray addObject:[WALCar carWithDictionary:dictionary]];
                 }
                 if ([carArray count] == kNumberPerPage) {
                     _pageNumber++;
                     completion(YES, YES, carArray, [WALStatusCount statusCountWithDictionary:responseObject[@"stat"]], responseObject[@"msg"]);
                 } else {
                     completion(YES, NO, carArray, [WALStatusCount statusCountWithDictionary:responseObject[@"stat"]], responseObject[@"msg"]);
                 }
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadCarListWithType:type completion:completion];
             } else {
                 completion(NO, NO, nil, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, NO, nil, nil, @"error");
         }];
}

- (void)loadAreaCarListWithType:(NSInteger)type
                         areaID:(NSString *)areaID
                     completion:(void (^)(BOOL success, BOOL hasMore, NSArray *carsArray, WALStatusCount *statusCount, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"areaid":areaID,
                                         @"refresh":@"1",
                                         @"type":[@(type) stringValue],
                                         @"pagesize":[@(kNumberPerPage) stringValue],
                                         @"curpage":[@(_pageNumber) stringValue],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID,
                                         @"version":[NSUserDefaults version]
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/MgtApp/GetIndexAreaStatInfo", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *carArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"monitArr"]) {
                     [carArray addObject:[WALCar carWithDictionary:dictionary]];
                 }
                 if ([carArray count] == kNumberPerPage) {
                     _pageNumber++;
                     completion(YES, YES, carArray, [WALStatusCount statusCountWithDictionary:responseObject[@"stat"]], responseObject[@"msg"]);
                 } else {
                     completion(YES, NO, carArray, [WALStatusCount statusCountWithDictionary:responseObject[@"stat"]], responseObject[@"msg"]);
                 }
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadAreaCarListWithType:type areaID:areaID completion:completion];
             } else {
                 completion(NO, NO, nil, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, NO, nil, nil, @"error");
         }];
}

- (void)loadCarDetailWithVehicleID:(NSString *)vehicleID
                        completion:(void (^)(BOOL success, WALCarDetail *carDetail, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"vehicleid":vehicleID,
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Vehicle/GetMonitDetailsInfo", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 completion(YES, [WALCarDetail carDetailWithDictionary:responseObject[@"monit"]], responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadCarDetailWithVehicleID:vehicleID completion:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadSimpleCarList:(void (^)(BOOL success, NSArray *simpleCarList, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"pagesize":@"10000",
                                         @"curpage":@"1",
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Vehicle/GetVehicleList", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *carArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"carArr"]) {
                     [carArray addObject:[WALSimpleCar simpleCarWithDictionary:dictionary]];
                 }
                 completion(YES, carArray, responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadSimpleCarList:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadCarTrackListWithVehicleID:(NSString *)vehicleID
                            startTime:(NSString *)startTime
                              endTime:(NSString *)endTime
                           completion:(void (^)(BOOL success, WALCarTrack *carTrack, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"stime":startTime,
                                         @"etime":endTime,
                                         @"vehicleid":vehicleID,
                                         @"pagesize":@"10000",
                                         @"curpage":@"1",
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Dynamiclist/GetTrackLinePageList", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 completion(YES, [WALCarTrack carTrackWithDictionary:responseObject], responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadCarTrackListWithVehicleID:vehicleID
                                           startTime:startTime
                                             endTime:endTime
                                          completion:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadCarPlayTrackListWithVehicleID:(NSString *)vehicleID
                                startTime:(NSString *)startTime
                                  endTime:(NSString *)endTime
                               completion:(void (^)(BOOL success, WALCarPlayTrack *carPlayTrack, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"stime":startTime,
                                         @"etime":endTime,
                                         @"vehicleid":vehicleID,
                                         @"pagesize":@"10000",
                                         @"curpage":@"1",
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Dynamiclist/GetTrackPlayList", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 completion(YES, [WALCarPlayTrack carPlayTrackWithDictionary:responseObject], responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadCarPlayTrackListWithVehicleID:vehicleID
                                               startTime:startTime
                                                 endTime:endTime
                                              completion:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadMapMonitWithVehicleID:(NSString *)vehicleID
                       completion:(void (^)(BOOL success, WALCar *car, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"vehicleid":vehicleID,
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Vehicle/GetMapMonitData", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 completion(YES, [WALCar carWithDictionary:responseObject[@"monit"]], responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadMapMonitWithVehicleID:vehicleID completion:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadPlaceNameWithVehicleID:(NSString *)vehicleID
                               lon:(NSString *)lon
                               lat:(NSString *)lat
                        completion:(void (^)(BOOL success, NSString *placeName, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"vehicleid":vehicleID,
                                         @"lat":lat,
                                         @"lon":lon,
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Dynamiclist/ConvertLonLatToPlaceName", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 completion(YES, responseObject[@"place"], responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadPlaceNameWithVehicleID:vehicleID
                                              lon:lon
                                              lat:lat
                                       completion:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadAreaList:(void (^)(BOOL success, NSArray *areaArray, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"areaname":@"",
                                         @"issearch":@"0",
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/Dynamiclist/GetIndexStatInfo", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *areaArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"statArr"]) {
                     [areaArray addObject:[WALArea areaWithDictionary:dictionary]];
                 }
                 completion(YES, areaArray, responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadAreaList:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadCarListWithAreaName:(NSString *)areaName
                     completion:(void (^)(BOOL success, NSArray *areaArray, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"areaname":areaName,
                                         @"issearch":@"0",
                                         @"version":[NSUserDefaults version],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/MgtApp/GetIndexAreaStatInfo", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *areaArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"statArr"]) {
                     [areaArray addObject:[WALArea areaWithDictionary:dictionary]];
                 }
                 completion(YES, areaArray, responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadAreaList:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

@end
