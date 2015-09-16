//
//  NSUserDefaults+Addition.m
//  E6Business
//
//  Created by wangxu on 15/9/1.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "NSUserDefaults+Addition.h"

static NSString *kWALUserIsLogin = @"kWALUserIsLogin";
static NSString *kWALUserInfo = @"kWALUserInfo";
static NSString *kYLYVersion = @"kYLYVersion";
static NSString *kSerivceParametersVersion = @"SerivceParametersVersion";

@implementation NSUserDefaults (Addition)

+ (void)saveLoginStatus:(BOOL)isLogin {
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kWALUserIsLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isLogin {
    return[[NSUserDefaults standardUserDefaults] boolForKey:kWALUserIsLogin];
}

+ (void)saveWalUser:(WALUser *)walUser {
     NSData *walUserData = [NSKeyedArchiver archivedDataWithRootObject:walUser];
    [[NSUserDefaults standardUserDefaults] setObject:walUserData forKey:kWALUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (WALUser *)loadWalUesr {
  NSData *walUserData = [[NSUserDefaults standardUserDefaults] objectForKey:kWALUserInfo];
  WALUser *walUser = [NSKeyedUnarchiver unarchiveObjectWithData:walUserData];
  return walUser;
}

+ (void)userLogout {
    [NSUserDefaults saveLoginStatus:NO];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWALUserInfo];
}

+ (void)saveVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:kYLYVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)version
{
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kYLYVersion];
    if (!version) {
        [self saveVersion:@"1"];
        return @"1";
    }
    return version;
}

+ (void)saveSerivceParametersVersion:(NSString *)serivceParametersVersion {
    [[NSUserDefaults standardUserDefaults] setObject:serivceParametersVersion forKey:kSerivceParametersVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)serivceParametersVersion {
    return [[NSUserDefaults standardUserDefaults]objectForKey:kSerivceParametersVersion];
}

@end
