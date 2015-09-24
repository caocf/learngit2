//
//  WALHomeService.m
//  Walmart
//
//  Created by wangxu on 15/9/16.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALHomeService.h"
#import "AFHTTPRequestOperationManager.h"
#import "WALReport.h"
#import "WALBoard.h"

@implementation WALHomeService

- (void)loadBoard:(void (^)(BOOL success, NSString *content, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"time":@"3000",
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID,
                                         @"version":[NSUserDefaults version]
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/DInfo/GetCorpContentDetail", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *boardArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"noticeArr"]) {
                     [boardArray addObject:[WALBoard boardWithDictionary:dictionary]];
                 }
                 if ([boardArray count] > 0) {
                     WALBoard *board = boardArray.firstObject;
                     completion(YES, board.content, responseObject[@"msg"]);
                 } else {
                     completion(YES, nil, responseObject[@"msg"]);
                 }
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadBoard:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

- (void)loadFDCWithType:(WALFDCType)type
             completion:(void (^)(BOOL success, NSArray *reportArray, NSString *message))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"time":[@(type) stringValue],
                                         @"webgisuserid":[NSUserDefaults loadWalUesr].webGisUserID,
                                         @"version":[NSUserDefaults version]
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Walmart/DInfo/GetFDCReportData", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger status = [responseObject[@"status"] integerValue];
             if (status == YLYStatusSuccess) {
                 NSMutableArray *reportArray = [NSMutableArray array];
                 for (NSDictionary *dictionary in responseObject[@"reportList"]) {
                     [reportArray addObject:[WALReport reportWithDictionary:dictionary]];
                 }
                 completion(YES, reportArray, responseObject[@"msg"]);
             } else if (status == YLYStatusVersionExpire) {
                 [NSUserDefaults saveVersion:responseObject[@"version"][@"vercode"]];
                 [self loadFDCWithType:type completion:completion];
             } else {
                 completion(NO, nil, responseObject[@"msg"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, nil, @"error");
         }];
}

@end
