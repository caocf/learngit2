//
//  WALCarTrack.h
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALCoor : NSObject

@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;

+ (WALCoor *)coorWithDictionary:(NSDictionary *)dictionary;

@end

@interface WALCarTrack : NSObject

@property (nonatomic, strong) NSString *startPlace;
@property (nonatomic, strong) NSString *endPlace;
@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, strong) NSString *totalMilleage;
@property (nonatomic, strong) NSArray *positionArray;

+ (WALCarTrack *)carTrackWithDictionary:(NSDictionary *)dictionary;

@end
