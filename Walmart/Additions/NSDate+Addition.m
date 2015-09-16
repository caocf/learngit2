//
//  NSDate+YGNSDate.m
//  DailyYoga
//
//  Created by zhen on 14-9-15.
//  Copyright (c) 2014年 zhen. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

+(NSDate *)getRealNowData
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return  [date dateByAddingTimeInterval:interval];
}

+ (NSDate *)dateFromString:(NSString *)dateString dateFormattter:(NSString *)dateFormattter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormattter];
    NSDate *date= [dateFormatter dateFromString:dateString];
    return date;
}

+ (BOOL)date:(NSDate * ) currentDate isBetweenFromDate:(NSDate *)FromDate toDate:(NSDate *)toDate
{
    if ([currentDate compare:FromDate]==NSOrderedDescending && [currentDate compare:toDate]==NSOrderedAscending)
    {
        //NSLog(@"该时间在 %@-%@ 之间！", FromDate, toDate);
        return YES;
    }
    return NO;
}

+ (NSDate *)exchangeDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *fromComps = [[NSDateComponents alloc] init];
    NSDateComponents *toComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    fromComps = [calendar components:unitFlags fromDate:fromDate];
    toComps = [calendar components:unitFlags fromDate:toDate];
    toComps.year = fromComps.year;
    toComps.month = fromComps.month;
    toComps.day = fromComps.day;
    return [calendar dateFromComponents:toComps];
}

+ (NSDate *)exchangeTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *fromComps = [[NSDateComponents alloc] init];
    NSDateComponents *toComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    fromComps = [calendar components:unitFlags fromDate:fromDate];
    toComps = [calendar components:unitFlags fromDate:toDate];
    toComps.hour = fromComps.hour;
    toComps.minute = fromComps.minute;
    toComps.second = fromComps.second;
    return [calendar dateFromComponents:toComps];
}

+ (NSDate *)changeTimeTo19FromDate:(NSDate *)fromDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *fromComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    fromComps = [calendar components:unitFlags fromDate:fromDate];
    fromComps.hour = 19;
    fromComps.minute = 0;
    fromComps.second = 0;
    return [calendar dateFromComponents:fromComps];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (NSDate *)dateWithType:(NSInteger)type
{
    NSTimeInterval secondsOneDay = 24 * 60 * 60;
    if (type == 1) {
        return [NSDate dateWithTimeIntervalSinceNow:-secondsOneDay];
    } else if (type == 2) {
        return [NSDate dateWithTimeIntervalSinceNow:-secondsOneDay * 2];
    } else {
        return [NSDate date];
    }
}

+ (NSString *)startStringWithType:(NSInteger)type
{
    return [[[self dateFormatterWithFormat:@"yyyy-MM-dd"] stringFromDate:[NSDate dateWithType:type]] stringByAppendingString:@" 00:00:00"];
}

+ (NSString *)endStringWithType:(NSInteger)type
{
    NSString *endSuffix = @" 23:59:59";
    if (type == 1) {
        return [[[self dateFormatterWithFormat:@"yyyy-MM-dd"] stringFromDate:[NSDate dateWithType:type]] stringByAppendingString:endSuffix];
    } else {
        return [[[self dateFormatterWithFormat:@"yyyy-MM-dd"] stringFromDate:[NSDate dateWithType:0]] stringByAppendingString:endSuffix];
    }
}

@end
