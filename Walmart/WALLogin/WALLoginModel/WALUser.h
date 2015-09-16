//
//  WALUser.h
//  Walmart
//
//  Created by zen on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALUser : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSNumber *corpID;
@property (nonatomic, strong) NSString *corpName;
@property (nonatomic, strong) NSNumber *hasAddCar;
@property (nonatomic, strong) NSNumber *hasAddDri;
@property (nonatomic, strong) NSNumber *hasPubWaybll;
@property (nonatomic, strong) NSNumber *pWebGisUserID;
@property (nonatomic, strong) NSNumber *useVersion;
@property (nonatomic, strong) NSString *userCode;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *webGisUserID;

+ (WALUser *)walUserWithDictionary:(NSDictionary *)userDictionary;

@end
