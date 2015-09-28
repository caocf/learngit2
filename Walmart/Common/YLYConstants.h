//
//  Constants.h
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#ifndef Walmart_Constants_h
#define Walmart_Constants_h
#define BaiduMapAK @"FlZKZK64IneHCGm2f5IcEvr2"
//外网
#define WALBaseURL @"http://cdis.app.e6gpshk.com"
//#define WALBaseURL @"http://cdis.app.e6xayf.com"
//内网
//#define WALBaseURL @"http://192.168.0.23:1458"
//账号密码yyt：4008861656
#define WALVersion @"3"
#define ServiceSuccess 1
#define kMainColor 0x007cc3
#define kLineColor 0xe5e5e5
#define RGB(x) [UIColor colorWithRed:((x & 0xff0000) >> 16)/255.0 green:((x & 0x00ff00) >> 8)/255.0 blue:(x & 0x0000ff)/255.0 alpha:1.0]
#define RGBA(x, a) [UIColor colorWithRed:((x & 0xff0000) >> 16)/255.0 green:((x & 0x00ff00) >> 8)/255.0 blue:(x & 0x0000ff)/255.0 alpha:a]
#define Font(x) [UIFont systemFontOfSize:(x)]
#define BoldFont(x) [UIFont boldSystemFontOfSize:(x)]
#define HelveticaLight_Font(x) [UIFont fontWithName:@"Helvetica-Light" size:(x)]
#define Helvetica_Font(x) [UIFont fontWithName:@"Helvetica" size:(x)]
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define DeviceIphone4s ([[UIScreen mainScreen]currentMode].size.height == 960 ?1:0)
#define DeviceIphone5s ([[UIScreen mainScreen]currentMode].size.height == 1136 ?1:0)
#define DeviceIphone61 ([[UIScreen mainScreen]currentMode].size.height == 1334 ?1:0)
#define DeviceIphone62 ([[UIScreen mainScreen]currentMode].size.height == 1136 ?1:0)
#define DeviceIphone6 (DeviceIphone61||DeviceIphone62)
#define DeviceIphone6Plus1 ([[UIScreen mainScreen]currentMode].size.height == 2208 ?1:0)
#define DeviceIphone6Plus2 ([[UIScreen mainScreen]currentMode].size.height == 2001 ?1:0)
#define DeviceIphone6Plus (DeviceIphone6Plus1||DeviceIphone6Plus2)
#define DeviceIpad (([[UIScreen mainScreen]currentMode].size.height == 1024||[[UIScreen mainScreen]currentMode].size.height == 2048) ?1:0)

typedef NS_ENUM(NSInteger, YLYStatus) {
    YLYStatusInvalid = -1,
    YLYStatusFailure,
    YLYStatusSuccess,
    YLYStatusParameterError,
    YLYStatusNoAuthority,
    YLYStatusNoVehicleAuthority,
    YLYStatusExecuteFailure,
    YLYStatusVersionExpire
};

typedef NS_ENUM(NSInteger, YLYRunStatus) {
    YLYRunStatusTotal,
    YLYRunStatusRunning,
    YLYRunStatusStop,
    YLYRunStatusAbnormal,
    YLYRunStatusOffline,
    YLYRunStatusAlarm
};

#endif
