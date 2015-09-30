//
//  WALAnnotation.h
//  Walmart
//
//  Created by wangxu on 15/9/30.
//  Copyright © 2015年 e6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALAnnotation : BMKPointAnnotation

@property (nonatomic, assign) NSInteger angle;
@property (nonatomic, strong) NSString *imageName;

@end
