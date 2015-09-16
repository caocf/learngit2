//
//  WALHomeService.h
//  Walmart
//
//  Created by wangxu on 15/9/16.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WALFDCType) {
    WALFDCTypeToday = 1,
    WALFDCTypeYesterday
};

@interface WALHomeService : NSObject

- (void)loadBoard:(void (^)(BOOL success, NSString *content, NSString *message))completion;
- (void)loadFDCWithType:(WALFDCType)type
             completion:(void (^)(BOOL success, NSArray *reportArray, NSString *message))completion;

@end
