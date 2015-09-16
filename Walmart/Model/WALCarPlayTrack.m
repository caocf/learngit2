//
//  WALCarPlayTrack.m
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarPlayTrack.h"

@implementation WALCarPlayPosition

+ (WALCarPlayPosition *)carPlayPositionWithDictionary:(NSDictionary *)dictionary
{
    WALCarPlayPosition *carPlayPosition = [[WALCarPlayPosition alloc] init];
    carPlayPosition.milleage = [dictionary strValue:@"CurOdom"];
    carPlayPosition.direction = [dictionary strValue:@"Direction"];
    carPlayPosition.lat = [dictionary strValue:@"Lat"];
    carPlayPosition.lon = [dictionary strValue:@"Lon"];
    carPlayPosition.SN = [dictionary strValue:@"SN"];
    carPlayPosition.speed = [dictionary strValue:@"Speed"];
    carPlayPosition.time = [dictionary strValue:@"Time"];
    return carPlayPosition;
}

@end

@implementation WALCarPlayTrack

+ (WALCarPlayTrack *)carPlayTrackWithDictionary:(NSDictionary *)dictionary
{
    WALCarPlayTrack *carPlayTrack = [[WALCarPlayTrack alloc] init];
    carPlayTrack.recordCount = [dictionary strValue:@"recordcnt"];
    carPlayTrack.allMilleage = [dictionary strValue:@"allodo"];
    NSMutableArray *trackArray = [NSMutableArray array];
    for (NSDictionary *posDictionary in dictionary[@"ptrackArr"]) {
        [trackArray addObject:[WALCarPlayPosition carPlayPositionWithDictionary:posDictionary]];
    }
    carPlayTrack.trackArray = trackArray;
    return carPlayTrack;
}

@end
