//
//  WALTextField.h
//  Walmart
//
//  Created by zen on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WALTextField : UITextField

@property (nonatomic ,assign) BOOL isSecure;
- (void)setSecureTextEntry:(BOOL) secureTextEntry;

@end
