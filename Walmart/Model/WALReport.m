//
//  WALReport.m
//  Walmart
//
//  Created by wangxu on 15/9/16.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALReport.h"

@implementation WALReport

+ (WALReport *)reportWithDictionary:(NSDictionary *)dictionary
{
    WALReport *report = [[WALReport alloc] init];
    report.FDC = [dictionary strValue:@"FDC"];
    report.LOS = [dictionary numberValue:@"LOS"];
    report.totalOutBound = [dictionary numberValue:@"OutBoundTotal"];
    report.shipperTrailer = [dictionary numberValue:@"ShipperTrailer"];
    report.onTimeTrailer = [dictionary numberValue:@"OnTimeTrailer"];
    report.delayTrailer = [dictionary numberValue:@"DelayTrailer"];
    report.delayStoreCount = [dictionary numberValue:@"DelayStoreCounts"];
    report.realCarNum = [dictionary numberValue:@"RealCarNum"];
    return report;
}

@end
