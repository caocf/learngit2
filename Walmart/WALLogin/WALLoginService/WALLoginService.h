//
//  WALLoginService.h
//  Walmart
//
//  Created by zen on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALLoginService : NSObject

- (void)loginWithName:(NSString *)name
             password:(NSString *)password
              version:(NSString *)version
           completion:(void (^)(BOOL success, NSString *message))completion;

@end
