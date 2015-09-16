//
//  WALSettingBtnView.h
//  Walmart
//
//  Created by zen on 15/9/12.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WALSettingBtnView : UIView

- (void) loadBtnViewWithSize:(CGSize)size
                    resource:(NSDictionary *)rescourceDic
                       target:(id)target
                       action:(SEL)action;

@end
