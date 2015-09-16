//
//  NSUserDefaults+Addition.h
//  E6Business
//
//  Created by wangxu on 15/9/1.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WALUser.h"

@interface NSUserDefaults (Addition)

+ (void)saveLoginStatus:(BOOL)isLogin;
+ (BOOL)isLogin;
+ (void)saveWalUser:(WALUser *)walUser;
+ (WALUser *)loadWalUesr;
+ (void)userLogout;
+ (void)saveSerivceParametersVersion:(NSString *)serivceParametersVersion;
+ (NSString *)serivceParametersVersion;

+ (void)saveVersion:(NSString *)version;
+ (NSString *)version;

@end
