//
//  WALReport.h
//  Walmart
//
//  Created by wangxu on 15/9/16.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WALFDCBarType) {
    WALFDCBarTypeTotaloutBound,
    WALFDCBarTypeShipperTrailer,
    WALFDCBarTypeOnTimeTrailer,
    WALFDCBarTypeDelayTrailer,
    WALFDCBarTypeDelayStoreCount,
    WALFDCBarTypeLOS
};

@interface WALReport : NSObject

@property (nonatomic, strong) NSString *FDC;
@property (nonatomic, strong) NSString *LOS;
@property (nonatomic, strong) NSString *totalOutBound;
@property (nonatomic, strong) NSString *shipperTrailer;
@property (nonatomic, strong) NSString *onTimeTrailer;
@property (nonatomic, strong) NSString *delayTrailer;
@property (nonatomic, strong) NSString *delayStoreCount;
@property (nonatomic, strong) NSString *realCarNum;

+ (WALReport *)reportWithDictionary:(NSDictionary *)dictionary;

@end
