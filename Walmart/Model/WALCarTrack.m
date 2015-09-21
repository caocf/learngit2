//
//  WALCarTrack.m
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarTrack.h"

@implementation WALCoor

+ (WALCoor *)coorWithDictionary:(NSDictionary *)dictionary
{
    WALCoor *coor = [[WALCoor alloc] init];
    coor.lon = [dictionary strValue:@"Lon"];
    coor.lat = [dictionary strValue:@"Lat"];
    return coor;
}

@end

@implementation WALCarTrack

+ (WALCarTrack *)carTrackWithDictionary:(NSDictionary *)dictionary
{
    WALCarTrack *carTrack = [[WALCarTrack alloc] init];
    carTrack.totalCount = [dictionary strValue:@"totalcnt"];
    carTrack.totalMilleage = [dictionary strValue:@"allodo"];
    carTrack.startPlace = [dictionary strValue:@"splace"];
    carTrack.endPlace = [dictionary strValue:@"eplace"];
//    carTrack.positionArray = dictionary[@"monitArr"];
    NSMutableArray *positionArray = [NSMutableArray array];
    for (NSDictionary *posDictionary in dictionary[@"monitArr"]) {
        [positionArray addObject:[WALCoor coorWithDictionary:posDictionary]];
    }
    carTrack.positionArray = positionArray;
    return carTrack;
}

@end
