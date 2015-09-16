//
//  WALStatusCount.m
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALStatusCount.h"

@implementation WALStatusCount

+ (WALStatusCount *)statusCountWithDictionary:(NSDictionary *)dictionary
{
    WALStatusCount *statusCount = [[WALStatusCount alloc] init];
    statusCount.alarmCount = [dictionary intValue:@"AlarmCnt"];
    statusCount.abnormalCount = [dictionary intValue:@"ExpCnt"];
    statusCount.runningCount = [dictionary intValue:@"RunCnt"];
    statusCount.stopCount = [dictionary intValue:@"StopCnt"];
    return statusCount;
}

@end
