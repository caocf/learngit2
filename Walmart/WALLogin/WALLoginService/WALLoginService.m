//
//  WALLoginService.m
//  Walmart
//
//  Created by zen on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALLoginService.h"
#import "AFHTTPRequestOperationManager.h"
#import "WALUser.h"
@implementation WALLoginService

- (void)loginWithName:(NSString *)name
             password:(NSString *)password
              version:(NSString *)version
           completion:(void (^)(BOOL success, NSString *message))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *originalParameters = @{@"name":name,
                                         @"password":[password md5String],
                                         @"version":version
                                         };
    NSDictionary *parameters = @{@"sid":[DesEncryptDecipher base64StringWithDictionary:originalParameters]};
    [manager GET:[NSString stringWithFormat:@"%@/Home/Login", WALBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([[responseObject objectForKey:@"status"] intValue] == ServiceSuccess) {
                 WALUser *walUser = [WALUser walUserWithDictionary:[responseObject objectForKey:@"user"]];
                 [NSUserDefaults saveWalUser:walUser];
                 [NSUserDefaults saveLoginStatus:YES];
                 completion(YES, @"登录成功");
             }
             else if ([[responseObject objectForKey:@"status"] intValue] == 6) {
                 NSDictionary *versionDic = [responseObject dictValue:@"version"];
                 NSString *serviceVersion = [versionDic strValue:@"vercode"];
                 [NSUserDefaults saveSerivceParametersVersion:serviceVersion
                  
                  
                  ];
                 [self loginWithName:name
                            password:password
                             version:serviceVersion
                          completion:completion];
             }
             else {
                 [NSUserDefaults saveLoginStatus:NO];
                  completion(NO, [responseObject objectForKey:@"msg"]);
             }
                    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             completion(NO, @"error");
        }];
}

@end
