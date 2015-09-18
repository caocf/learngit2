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
@property (nonatomic, strong) NSNumber *LOS;
@property (nonatomic, strong) NSNumber *totalOutBound;
@property (nonatomic, strong) NSNumber *shipperTrailer;
@property (nonatomic, strong) NSNumber *onTimeTrailer;
@property (nonatomic, strong) NSNumber *delayTrailer;
@property (nonatomic, strong) NSNumber *delayStoreCount;
@property (nonatomic, strong) NSNumber *realCarNum;

+ (WALReport *)reportWithDictionary:(NSDictionary *)dictionary;

@end
