//
//  WALAnnotationView.m
//  Walmart
//
//  Created by wangxu on 15/9/30.
//  Copyright © 2015年 e6. All rights reserved.
//

#import "WALAnnotationView.h"

@interface WALAnnotationView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation WALAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setImageName:(NSString *)imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)setAngle:(NSInteger)angle
{
    self.imageView.transform = CGAffineTransformMakeRotation(angle / 180.0 * M_PI );
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 34)];
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end
