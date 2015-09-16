//
//  WALCarPlayTrack.h
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALCarPlayPosition : NSObject

@property (nonatomic, strong) NSString *milleage;
@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *SN;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *time;

+ (WALCarPlayPosition *)carPlayPositionWithDictionary:(NSDictionary *)dictionary;

@end

@interface WALCarPlayTrack : NSObject

@property (nonatomic, strong) NSString *recordCount;
@property (nonatomic, strong) NSString *allMilleage;
@property (nonatomic, strong) NSArray *trackArray;

+ (WALCarPlayTrack *)carPlayTrackWithDictionary:(NSDictionary *)dictionary;

@end
