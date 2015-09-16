//
//  WALSettingBtnView.m
//  Walmart
//
//  Created by zen on 15/9/12.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALSettingBtnView.h"

@implementation WALSettingBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark load Action

- (void) loadBtnViewWithSize:(CGSize)size
                    resource:(NSDictionary *)rescourceDic
                      target:(id)target
                      action:(SEL)action{
    UIImage *leftLogoImage = [UIImage imageNamed:[rescourceDic strValue:@"leftImageName"]];
    UIImage *rightLogoImage= [UIImage imageNamed:[rescourceDic strValue:@"rightImageName"]];
    NSString *defaultText = [rescourceDic strValue:@"defaultText"];
    NSString *textColorString = [rescourceDic strValue:@"textColor"];
    [self setFrame:CGRectMake(0, 0, size.width, size.height)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = self.frame;
    [self addSubview:btn];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 15 - 20, 0, 15, 15)];
    [leftImageView setImage:leftLogoImage];
    [rightImageView setImage:rightLogoImage];
    [self addSubview:leftImageView];
    [self addSubview:rightImageView];
    UILabel *defaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.right + 10, 0, self.width - (leftImageView.right + 10) - 15 - 20, 20)];
    [defaultLabel setText:defaultText];
    [defaultLabel setTextColor:[UIColor hexStringToColor:textColorString]];
    [self addSubview:defaultLabel];
}

@end
