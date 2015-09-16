//
//  NSDate+YGNSDate.h
//  DailyYoga
//
//  Created by zhen on 14-9-15.
//  Copyright (c) 2014年 zhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

+ (NSDate *)getRealNowData;
+ (NSDate *)dateFromString:(NSString *)dateString dateFormattter:(NSString *)dateFormattter;
+ (BOOL)date:(NSDate *)currentDate isBetweenFromDate:(NSDate *)FromDate toDate:(NSDate *)toDate;
+ (NSDate *)exchangeDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)exchangeTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)changeTimeTo19FromDate:(NSDate *)fromDate;

+ (NSString *)startStringWithType:(NSInteger)type;
+ (NSString *)endStringWithType:(NSInteger)type;

@end
