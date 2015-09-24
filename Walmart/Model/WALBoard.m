//
//  WALBoard.m
//  Walmart
//
//  Created by wangxu on 15/9/24.
//  Copyright © 2015年 e6. All rights reserved.
//

#import "WALBoard.h"

@implementation WALBoard

+ (WALBoard *)boardWithDictionary:(NSDictionary *)dictionary
{
    WALBoard *board = [[WALBoard alloc] init];
    board.ID = [dictionary strValue:@"MessageID"];
    board.content = [dictionary strValue:@"MsgContent"];
    board.time = [dictionary strValue:@"PubTime"];
    board.userID = [dictionary strValue:@"PubUserID"];
    board.userName = [dictionary strValue:@"PubUserName"];
    board.title = [dictionary strValue:@"Title"];
    return board;
}

@end
