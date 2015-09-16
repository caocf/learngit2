//
//  NSArray+NSArray_Resource.m
//  Walmart
//
//  Created by zen on 15/9/12.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "NSArray+NSArray_Resource.h"

@implementation NSArray (NSArray_Resource)

+ (NSArray *)getSettingBtnViewResourceArray {
    NSArray *setViewInfoArray = @[
                                  @{@"defaultText":@"系统设置",
                                    @"leftImageName":@"icon_w40_setUp",
                                    @"rightImageName":@"icon_w30_arrow_go",
                                    @"index":@"0",
                                    @"textColor":@"0Xffffff"
                                    },
                                  @{@"defaultText":@"修改密码",
                                    @"leftImageName":@"icon_w40_setUp",
                                    @"rightImageName":@"icon_w30_arrow_go",
                                    @"index":@"1",
                                    @"textColor":@"0Xffffff"
                                    },
                                  @{@"defaultText":@"意见反馈",
                                    @"leftImageName":@"icon_w40_setUp",
                                    @"rightImageName":@"icon_w30_arrow_go",
                                    @"index":@"2",
                                    @"textColor":@"0Xffffff"
                                    },
                                  ];
    return setViewInfoArray;
}

@end
