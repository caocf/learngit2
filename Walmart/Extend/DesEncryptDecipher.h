//
//  DesEncryptDecipher.h
//  E6yun
//
//  Created by Yosemite Retail on 15/2/6.
//  Copyright (c) 2015年 Yosemite Retail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesEncryptDecipher : NSObject

+ (NSString *)base64StringWithDictionary:(NSDictionary *)dictionary;

//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key;

//MD5 加密
+(NSString*)md5Str:(NSString*)str;

@end
