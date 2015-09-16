//
//  NSDictionary+NSDictionary_Addition.h
//  Walmart
//
//  Created by zen on 15/9/12.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_Addition)

- (float)floatValue:(NSString*)path;
- (NSInteger)intValue:(NSString*)path;
- (NSString *)strValue:(NSString*)path;
- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue;
- (float)floatValue:(NSString*)path default:(float)defValue;
- (NSString *)strValue:(NSString*)path default:(NSString*)defValue;
- (NSString *)strValueDeleteAllReturn:(NSString*)path;
- (NSString *)strValueDeleteReturn:(NSString*)path;
- (NSDictionary *)dictValueDeleteReturn;
- (NSDate *)dateValue:(NSString *)path;
- (NSDate *)dateValue:(NSString *)path default:(NSDate *)defValue;
- (NSDictionary *)dictValue:(NSString *)path;
- (NSDictionary *)dictValue:(NSString *)path default:(NSDictionary *)defValue;
- (NSArray *)arrayValue:(NSString *)path;
- (NSArray *)arrayValue:(NSString *)path default:(NSArray *)defValue;
- (NSNumber *)numberValue:(NSString *)path;

@end
