//
//  NSDictionary+NSDictionary_Addition.m
//  Walmart
//
//  Created by zen on 15/9/12.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "NSDictionary+NSDictionary_Addition.h"

@implementation NSDictionary (NSDictionary_Addition)

- (NSString*)strValueDeleteReturn:(NSString*)path{
    NSString*msg = [self objectForKey:path];
    if(!msg){
        return @"";
    }
    if ([msg respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        msg = [msg stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    }
    return msg;
}
- (NSString*)strValueDeleteAllReturn:(NSString*)path{
    NSString*msg = [self objectForKey:path];
    if(!msg){
        return @"";
    }
    if([msg respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]){
        msg = [msg stringByReplacingOccurrencesOfString:@"<br />\r\n" withString:@""];
    }
    return msg;
}
- (NSDictionary *)dictValueDeleteReturn{
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self];
    [tmpDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [obj stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
            [tmpDict setObject:obj forKey:key];
        }
    }];
    return tmpDict;
}

- (float)floatValue:(NSString *)path {
    return [self floatValue:path default:0.0];
}

- (NSInteger)intValue:(NSString*)path {
    return [self intValue:path default:0];
}

- (NSString*)strValue:(NSString*)path {
    return [self strValue:path default:@""];
}

- (NSNumber *)numberValue:(NSString *)path {
    return [self numberValue:path default:[NSNumber numberWithInt:0]];
}

- (float)floatValue:(NSString*)path default:(float)defValue{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj floatValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj floatValue];
    else
        return defValue;
}

- (NSNumber*)numberValue:(NSString*)path default:(NSNumber*)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return (NSNumber *)obj;
    else
        return defValue;
}
- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj intValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj intValue];
    else
        return defValue;
}

- (NSString*)strValue:(NSString*)path default:(NSString*)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj stringValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj length] <= 0 ? defValue : (NSString*)obj;
    else
        return defValue;
}

- (NSDate *)dateValue:(NSString *)path{
    
    return [self dateValue:path default:nil];
}
- (NSDate *)dateValue:(NSString *)path default:(NSDate *)defValue{
    NSObject *obj = [self valueForKey:path];
    if ([obj isKindOfClass:[NSDate class]]) {
        return (NSDate *)obj;
    }
    else
        return defValue;
}

-(NSDictionary *)dictValue:(NSString *)path{
    return [self dictValue:path default:[NSDictionary dictionary]];
}
-(NSDictionary *)dictValue:(NSString *)path default:(NSDictionary *)defValue{
    
    NSObject *obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }else
        return defValue;
}

-(NSArray *)arrayValue:(NSString *)path{
    return [self arrayValue:path default: [NSArray array]];
}
-(NSArray *)arrayValue:(NSString *)path default:(NSArray *)defValue{
    NSObject *obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }else
        return defValue;
    
}

@end
