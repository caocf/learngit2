//
//  WALArea.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALArea : NSObject

@property (nonatomic, strong) NSString *allCount;
@property (nonatomic, strong) NSString *runningCount;
@property (nonatomic, strong) NSString *offlineCount;
@property (nonatomic, strong) NSString *stopCount;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;

+ (WALArea *)areaWithDictionary:(NSDictionary *)dictionary;

@end
