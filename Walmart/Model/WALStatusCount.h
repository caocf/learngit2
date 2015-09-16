//
//  WALStatusCount.h
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALStatusCount : NSObject

@property (nonatomic, assign) NSInteger alarmCount;
@property (nonatomic, assign) NSInteger abnormalCount;
@property (nonatomic, assign) NSInteger runningCount;
@property (nonatomic, assign) NSInteger stopCount;

+ (WALStatusCount *)statusCountWithDictionary:(NSDictionary *)dictionary;

@end
