//
//  WALUser.m
//  Walmart
//
//  Created by zen on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALUser.h"

@implementation WALUser

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _corpID = [aDecoder decodeObjectForKey:@"corpID"];
        _corpName = [aDecoder decodeObjectForKey:@"corpName"];
        _hasAddCar = [aDecoder decodeObjectForKey:@"hasAddCar"];
        _hasAddDri = [aDecoder decodeObjectForKey:@"hasAddDri"];
        _hasPubWaybll = [aDecoder decodeObjectForKey:@"hasPubWaybll"];
        _pWebGisUserID = [aDecoder decodeObjectForKey:@"pWebGisUserID"];
        _useVersion = [aDecoder decodeObjectForKey:@"useVersion"];
        _userCode = [aDecoder decodeObjectForKey:@"userCode"];
        _userID = [aDecoder decodeObjectForKey:@"userID"];
        _userName = [aDecoder decodeObjectForKey:@"userName"];
        _webGisUserID = [aDecoder decodeObjectForKey:@"webGisUserID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.corpID forKey:@"corpID"];
    [aCoder encodeObject:self.corpName forKey:@"corpName"];
    [aCoder encodeObject:self.hasAddCar forKey:@"hasAddCar"];
    [aCoder encodeObject:self.hasAddDri forKey:@"hasAddDri"];
    [aCoder encodeObject:self.hasPubWaybll forKey:@"hasPubWaybll"];
    [aCoder encodeObject:self.pWebGisUserID forKey:@"pWebGisUserID"];
    [aCoder encodeObject:self.useVersion forKey:@"useVersion"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.webGisUserID forKey:@"webGisUserID"];
}

- (id)copyWithZone:(NSZone *)zone {
    WALUser *walUser = [[[self class] allocWithZone:zone] init];
    walUser.corpID = self.corpID;
    walUser.corpName = self.corpName;
    walUser.hasAddCar = self.hasAddCar;
    walUser.hasAddDri = self.hasAddDri;
    walUser.hasPubWaybll = self.hasPubWaybll;
    walUser.pWebGisUserID = self.pWebGisUserID;
    walUser.useVersion = self.useVersion;
    walUser.userCode = self.userCode;
    walUser.userID = self.userID;
    walUser.userName = self.userName;
    walUser.webGisUserID = self.webGisUserID;
    return walUser;
}

+ (WALUser *)walUserWithDictionary:(NSDictionary *)userDictionary {
    WALUser *walUser = [[WALUser alloc] init];
    walUser.corpID = [userDictionary numberValue:@"CorpID"];
    walUser.corpName = [userDictionary strValue:@"CorpName"];
    walUser.hasAddCar = [userDictionary numberValue:@"HasAddCar"];
    walUser.hasAddDri = [userDictionary numberValue:@"HasAddDri"];
    walUser.hasPubWaybll = [userDictionary numberValue:@"HasPubWaybll"];
    walUser.pWebGisUserID = [userDictionary numberValue:@"PWebGisUserID"];
    walUser.useVersion = [userDictionary numberValue:@"UseVersion"];
    walUser.userCode = [userDictionary strValue:@"UserCode"];
    walUser.userID = [userDictionary numberValue:@"UserID"];
    walUser.userName = [userDictionary strValue:@"UserName"];
    walUser.webGisUserID = [userDictionary numberValue:@"WebGisUserID"];
    return walUser;
}
@end
