//
//  GKBarGraph.m
//  GraphKit
//
//  Copyright (c) 2014 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "GKBarGraph.h"
#import "NSArray+MK_Block.h"
#import "NSArray+MK_Misc.h"

//#import <FrameAccessor/FrameAccessor.h>
//#import <MKFoundationKit/NSArray+MK.h>

#import "GKBar.h"

static CGFloat kDefaultBarHeight = 22;
static CGFloat kDefaultBarWidth = 220;
static CGFloat kDefaultBarMargin = 20;
static CGFloat kDefaultLabelWidth = 60;
static CGFloat kDefaultLabelHeight = 15;

static CGFloat kDefaultAnimationDuration = 2.0;

@implementation GKBarGraph

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)_init {
    self.animationDuration = kDefaultAnimationDuration;
    self.barHeight = kDefaultBarHeight;
//    self.barWidth = kDefaultBarWidth;
    self.barWidth = (self.width - kDefaultLabelWidth * 2 - 10);
    self.marginBar = kDefaultBarMargin;
}

- (void)setAnimated:(BOOL)animated {
    _animated = animated;
    [self.bars mk_each:^(GKBar *item) {
        item.animated = animated;
    }];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    [self.bars mk_each:^(GKBar *item) {
        item.animationDuration = animationDuration;
    }];
}

- (void)setBarColor:(UIColor *)color {
    _barColor = color;
    [self.bars mk_each:^(GKBar *item) {
        item.foregroundColor = color;
    }];
}

- (void)draw {
    [self _construct];
    [self.bars mk_each:^(GKBar *item) {
        item.max = self.max;
    }];
    [self _drawBars];
}

- (void)_construct {
    NSAssert(self.dataSource, @"GKBarGraph : No data source is assgined.");
    
    if ([self _hasBars]) [self _removeBars];
    if ([self _hasLabels]) [self _removeLabels];
    if ([self _hasLabels2]) [self _removeLabels2];
    
    [self _constructBars];
    [self _constructLabels];
    [self _constructLabels2];
    
    [self _positionBars];
    [self _positionLabels];
    [self _positionLabels2];
}

- (BOOL)_hasBars {
    return ![self.bars mk_isEmpty];
}

- (void)_constructBars {
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        GKBar *item = [GKBar create];
        if ([self barColor]) item.foregroundColor = [self barColor];
        [items addObject:item];
    }
    self.bars = items;
}

- (void)_removeBars {
    [self.bars mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionBars {
    __block CGFloat y = 0;
    
    CGFloat x = [self _barStartX];
    [self.bars mk_each:^(GKBar *item) {
        item.frame = CGRectMake(x, y, _barWidth, _barHeight);
        [self addSubview:item];
        y += [self _barSpace];
    }];
    
    self.contentSize = CGSizeMake(self.width, MAX(self.height, self.bars.count * [self _barSpace]));
}

- (CGFloat)_barSpace {
    return (self.barHeight + self.marginBar);
}

- (CGFloat)_barStartX {
    return (self.width - self.barWidth);
}

- (BOOL)_hasLabels {
    return ![self.labels mk_isEmpty];
}

- (void)_constructLabels {
    
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:13];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource titleForBarAtIndex:idx];
        
        [items addObject:item];
    }
    self.labels = items;
}

- (void)_removeLabels {
    [self.labels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionLabels {
    
    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKBar *bar) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat startX = 0;
        CGFloat startY = idx * [self _barSpace];
        
        UILabel *label = [self.labels objectAtIndex:idx];
        label.left = startX;
        label.top = startY;
        label.centerY = bar.centerY;
        
        [self addSubview:label];
        
        bar.left = labelWidth + 5;
        idx++;
    }];
}


- (BOOL)_hasLabels2 {
    return ![self.labels2 mk_isEmpty];
}

- (void)_constructLabels2 {
    
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:13];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource title2ForBarAtIndex:idx];
        
        [items addObject:item];
    }
    self.labels2 = items;
}

- (void)_removeLabels2 {
    [self.labels2 mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionLabels2 {
    
    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKBar *bar) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat startY = idx * [self _barSpace];
        
        UILabel *label = [self.labels2 objectAtIndex:idx];
        
        label.left = bar.right + 5;
        label.top = startY;
        label.centerY = bar.centerY;
        
        [self addSubview:label];
        
        bar.left = labelWidth + 5;
        idx++;
    }];
}

- (void)_drawBars {
    __block NSInteger idx = 0;
    id source = self.dataSource;
    [self.bars mk_each:^(GKBar *item) {
        
        if ([source respondsToSelector:@selector(animationDurationForBarAtIndex:)]) {
            item.animationDuration = [source animationDurationForBarAtIndex:idx];
        }
        
        if ([source respondsToSelector:@selector(colorForBarAtIndex:)]) {
            item.foregroundColor = [source colorForBarAtIndex:idx];
        }
        
        if ([source respondsToSelector:@selector(colorForBarBackgroundAtIndex:)]) {
            item.backgroundColor = [source colorForBarBackgroundAtIndex:idx];
        }
        
        item.percentage = [[source valueForBarAtIndex:idx] doubleValue];
        idx++;
    }];
}

- (void)reset {
    [self.bars mk_each:^(GKBar *item) {
        [item reset];
    }];
}

@end
