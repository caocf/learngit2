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
    report.LOS = [dictionary strValue:@"LOS"];
    report.totalOutBound = [dictionary strValue:@"OutBoundTotal"];
    report.shipperTrailer = [dictionary strValue:@"ShipperTrailer"];
    report.onTimeTrailer = [dictionary strValue:@"OnTimeTrailer"];
    report.delayTrailer = [dictionary strValue:@"DelayTrailer"];
    report.delayStoreCount = [dictionary strValue:@"DelayStoreCounts"];
    report.realCarNum = [dictionary strValue:@"RealCarNum"];
    return report;
}

@end
