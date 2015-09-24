//
//  WALBoard.h
//  Walmart
//
//  Created by wangxu on 15/9/24.
//  Copyright © 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALBoard : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *title;

+ (WALBoard *)boardWithDictionary:(NSDictionary *)dictionary;

@end
