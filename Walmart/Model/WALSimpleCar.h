//
//  WALSimpleCar.h
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALSimpleCar : NSObject

@property (nonatomic, strong) NSString *DS;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *load;
@property (nonatomic, strong) NSString *regName;
@property (nonatomic, strong) NSString *TN;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *vehicleID;

+ (WALSimpleCar *)simpleCarWithDictionary:(NSDictionary *)dictionary;

@end
