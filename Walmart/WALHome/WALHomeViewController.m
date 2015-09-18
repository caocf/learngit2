//
//  WALHomeViewController.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALHomeViewController.h"
#import "WALBoardView.h"
#import "ChoiceSegmentedView.h"
#import "WALHomeService.h"
#import "GKBarGraph.h"
#import "UIColor+GraphKit.h"

@interface WALHomeViewController () <GKBarGraphDataSource>

@property (nonatomic, strong) WALBoardView *boardView;
@property (nonatomic, strong) ChoiceSegmentedView *segmentedView;
@property (nonatomic, strong) WALHomeService *homeService;
@property (nonatomic, strong) NSArray *buttonsArray;
@property (nonatomic, strong) NSArray *todayFDCArray;
@property (nonatomic, strong) NSArray *yesterdayFDCArray;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) WALFDCType FDCType;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) GKBarGraph *barGraph;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WALHomeViewController

- (id)init
{
    if (self = [super init]) {
        _homeService = [[WALHomeService alloc] init];
        _todayFDCArray = [NSArray array];
        _yesterdayFDCArray = [NSArray array];
        _FDCType = WALFDCTypeYesterday;
        _selectedIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = RGB(0xf0f0f0);
    
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
//    [self.homeService loadBoard:^(BOOL success, NSString *content, NSString *message) {
//        [DejalBezelActivityView removeView];
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
//        if (success) {
//            [self.boardView setWithText:content imageName:nil];
//        }
//    }];
    [self setupUI];
//    [self didClickChoiceSegmentView:_FDCType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (void)didClickChoiceSegmentView:(NSInteger)selectedIndex
{
    _FDCType = selectedIndex;
    if ((_FDCType == WALFDCTypeYesterday && self.yesterdayFDCArray.count > 0) || (_FDCType == WALFDCTypeToday && self.todayFDCArray.count > 0)) {
        [self drawBar];
        return;
    }
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.homeService loadFDCWithType:_FDCType completion:^(BOOL success, NSArray *reportArray, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            if (_FDCType == WALFDCTypeToday) {
                self.todayFDCArray = reportArray;
            } else {
                self.yesterdayFDCArray = reportArray;
            }
            [self drawBar];
        }
    }];
}

- (void)didClickButton:(UIButton *)sender
{
    _selectedIndex = sender.tag;
    [self drawBar];
}

- (void)drawBar
{
    for (UIButton *button in self.buttonsArray) {
        if (_selectedIndex == button.tag) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    NSArray *keyArray = @[@"totalOutBound", @"shipperTrailer", @"onTimeTrailer", @"delayTrailer", @"delayStoreCount", @"LOS"];
    NSArray *FDCArray = _FDCType == WALFDCTypeToday ? self.todayFDCArray : self.yesterdayFDCArray;
    self.nameArray = [FDCArray valueForKeyPath:@"FDC"];
    self.dataArray = [FDCArray valueForKeyPath:keyArray[_selectedIndex]];
    self.barGraph.max = [[self.dataArray valueForKeyPath:@"@max.intValue"] doubleValue];
    [self.barGraph draw];
}

- (void)setupUI
{
    CGFloat gap = 10;
    CGFloat width = 60;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentedView.bottom, self.view.width, width + gap * 2)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    NSArray *titleArray = @[@"出货\n总量", @"出货\n车次", @"准时到\n店车次", @"延误\n车次", @"延误到店\n的店数", @"LOS%"];
    CGFloat left = gap;
    NSMutableArray *buttonsArray = [NSMutableArray array];
    NSInteger tag = 0;
    for (NSString *title in titleArray) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(left, gap, width, width);
        button.layer.borderColor = RGB(0xe4e4e4).CGColor;
        button.layer.borderWidth = 2.5;
        button.layer.cornerRadius = width/2.0;
        button.layer.masksToBounds = YES;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.font = Font(12);
        [button setTitleColor:RGB(0xaaaaaa) forState:UIControlStateNormal];
        [button setTitleColor:RGB(0xffffff) forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"open_icon.png"] forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        button.tag = tag++;
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        [buttonsArray addObject:button];
        left = left + width + gap;
    }
    self.buttonsArray = buttonsArray;
    _scrollView.contentSize = CGSizeMake(MAX(_scrollView.width, left), _scrollView.height);
    
    [self.view addSubview:_scrollView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.bottom - 0.5, _scrollView.width, 0.5)];
    lineView.backgroundColor = RGB(kLineColor);
    [self.view addSubview:lineView];
}

#pragma mark - GKBarGraphDataSource

- (NSInteger)numberOfBars
{
    return [self.dataArray count];
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index
{
    return [self.dataArray objectAtIndex:index];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index
{
    NSArray *colors = @[[UIColor gk_turquoiseColor],
                        [UIColor gk_peterRiverColor],
                        [UIColor gk_alizarinColor],
                        [UIColor gk_amethystColor],
                        [UIColor gk_emerlandColor],
                        [UIColor gk_sunflowerColor]
                        ];
    return [colors objectAtIndex:(index % colors.count)];
}

- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index
{
    CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
    CGFloat max = [[self.dataArray valueForKeyPath:@"@max.intValue"] doubleValue];
    percentage = (percentage / max);
    return (self.barGraph.animationDuration * percentage);
}

- (NSString *)titleForBarAtIndex:(NSInteger)index
{
    return [self.nameArray objectAtIndex:index];
}

- (NSString *)title2ForBarAtIndex:(NSInteger)index
{
    return [[self.dataArray objectAtIndex:index] stringValue];
}

#pragma mark - getter/setter

- (WALBoardView *)boardView
{
    if (!_boardView) {
        _boardView = [[WALBoardView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 52)];
        _boardView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_boardView];
    }
    return  _boardView;
}

- (ChoiceSegmentedView *)segmentedView
{
    if (!_segmentedView) {
        _segmentedView = [[ChoiceSegmentedView alloc] initWithFrame:CGRectMake(0, self.boardView.bottom + 8, self.view.width, 30)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _segmentedView.width, 0.5)];
        lineView.backgroundColor = RGB(kLineColor);
        [_segmentedView addSubview:lineView];
        _segmentedView.backgroundColor = [UIColor whiteColor];
        NSArray *contents = @[@"昨日", @"今日"];
        [_segmentedView setWithSize2:CGSizeMake(_segmentedView.width, _segmentedView.height)
                   backImageViewName:nil
                     segmentedNumber:[contents count]
                            contents:contents
                              images:nil
                    backgroundColors:@[RGB(0xf5f5f5), [UIColor clearColor]]
                              colors:@[RGB(0x666666), RGB(0x222222)]
                         selectedNum:0
                            fontSize:12];
        __weak typeof(self) weakSelf = self;
        _segmentedView.forumSegmentedBlock = ^(NSInteger clickNumber){
            NSInteger index = WALFDCTypeYesterday - clickNumber;
//            [weakSelf didClickChoiceSegmentView:index];
        };
        [self.view addSubview:_segmentedView];
    }
    return  _segmentedView;
}

- (GKBarGraph *)barGraph
{
    if (!_barGraph) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.bottom, self.view.width, self.view.height - self.scrollView.bottom)];
        view.backgroundColor = RGB(0xffffff);
        [self.view addSubview:view];
        
        _barGraph = [[GKBarGraph alloc] initWithFrame:CGRectMake(0, 10, self.view.width, view.height - 20)];
        _barGraph.dataSource = self;
        _barGraph.backgroundColor = [UIColor whiteColor];
        [view addSubview:_barGraph];
    }
    return _barGraph;
}

@end
