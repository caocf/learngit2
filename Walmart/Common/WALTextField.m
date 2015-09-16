//
//  WALTextField.m
//  Walmart
//
//  Created by zen on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALTextField.h"

@implementation WALTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 0;
    return iconRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editRect = [super editingRectForBounds:bounds];
    editRect.origin.x += 17;
    editRect.size.width -= (self.leftView.width + 17 + 17);
    return editRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect editRect = [super editingRectForBounds:bounds];
    editRect.origin.x += 17;
    editRect.size.width -= (self.leftView.width + 17 + 17);
    return editRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect editRect = [super editingRectForBounds:bounds];
    editRect.origin.x += 17;
    editRect.size.width -= 17;
    return editRect;
}

-(CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];
    clearButtonRect.origin.x -= (19+clearButtonRect.size.width);
    return clearButtonRect;
}

- (void)setSecureTextEntry:(BOOL) secureTextEntry {
    secureTextEntry = self.isSecure;
    [super setSecureTextEntry:self.isSecure];
    self.isSecure = !self.isSecure;
}

@end
