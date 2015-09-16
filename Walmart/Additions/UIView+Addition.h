//
//  UIView+Addition.h
//  E6Business
//
//  Created by wangxu on 15/9/1.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

- (void)setLeft:(CGFloat)left;

- (void)setRight:(CGFloat)right;

- (void)setTop:(CGFloat)top;

- (void)setBottom:(CGFloat)bottom;

- (void)setCenterX:(CGFloat)centerX;

- (void)setCenterY:(CGFloat)centerY;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (CGFloat)left;

- (CGFloat)right;

- (CGFloat)top;

- (CGFloat)bottom;

- (CGFloat)centerX;

- (CGFloat)centerY;

- (CGFloat)width;

- (CGFloat)height;

- (void)removeAllSubViews;

+(void)AddRoundedCorners:(UIView*)view size:(float)size type:(int)type;

@end
