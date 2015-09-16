//
//  WALArea.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALArea.h"

@implementation WALArea

+ (WALArea *)areaWithDictionary:(NSDictionary *)dictionary
{
    WALArea *area = [[WALArea alloc] init];
    area.allCount = [dictionary strValue:@"AllCnt"];
    area.runningCount = [dictionary strValue:@"RunCnt"];
    area.offlineCount = [dictionary strValue:@"OffLineCnt"];
    area.stopCount = [dictionary strValue:@"StopCnt"];
    area.ID = [dictionary strValue:@"AreaID"];
    area.name = [dictionary strValue:@"AreaName"];
    return area;
}

@end
