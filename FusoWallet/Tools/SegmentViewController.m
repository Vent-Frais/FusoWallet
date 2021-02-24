//
//  SegmentViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/26.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "SegmentViewController.h"
//#import "BDTUserCollectionViewController.h"

#define HEADBTN_TAG                 10000
#define Default_BottomLineColor     [UIColor colorNamed:@"CommonGreenColor"]
#define Default_BottomLineHeight    2
#define Default_ButtonHeight        48
#define Default_BottomLineWidth     self.buttonWidth
#define Default_TitleColor          [UIColor colorNamed:@"CommonGreenColor"]
#define Default_SeletedTitleColor   [UIColor colorNamed:@"CommonGrayColor"]
#define Default_Font                [UIFont fontWithName:@"OPPOSans-M" size:16]
#define Default_HeadViewBackgroundColor  [UIColor colorNamed:@"CellBGColor"]
#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight            [[UIScreen mainScreen]bounds].size.height

@interface SegmentViewController ()<UIScrollViewDelegate/*,ReturnRowNumberDelegate*/>
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorNamed:@"BackgroundColor"];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRowNumber:) name:@"SetSegmentHeight" object:nil];
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [IQKeyboardManager sharedManager].enable = YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSegment
{
    [self addButtonInScrollHeader:_titleArray];
    [self addContentViewScrollView:_subViewControllers];
}

/*!
 *  @brief  根据传入的title数组新建button显示在顶部scrollView上
 *
 *  @param titleArray  title数组
 */
- (void)addButtonInScrollHeader:(NSArray *)titleArray
{
    
    self.headerView.frame = CGRectMake(0, 0, _viewFrame.size.width, self.buttonHeight);
    if (_segmentHeaderType == 0) {
        self.headerView.contentSize = CGSizeMake(self.buttonWidth * titleArray.count, self.buttonHeight);
    }
    else {
        self.headerView.contentSize = CGSizeMake(_viewFrame.size.width, self.buttonHeight);
    }
    [self.view addSubview:self.headerView];
    _buttonArray = [NSMutableArray array];
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.backgroundColor = Default_HeadViewBackgroundColor;
        segmentBtn.frame = CGRectMake(self.buttonWidth * index, 0, self.buttonWidth, self.buttonHeight);
        [segmentBtn setTitle:titleArray[index] forState:UIControlStateNormal];
        segmentBtn.titleLabel.font = self.font;
        segmentBtn.tag = index + HEADBTN_TAG;
//        segmentBtn.backgroundColor = Default_HeadViewBackgroundColor;
        [segmentBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [segmentBtn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (index == 0) {
            segmentBtn.selected = YES;
            self.selectIndex = segmentBtn.tag;
            [UIView animateWithDuration:0.3 animations:^{
                segmentBtn.transform = CGAffineTransformMakeScale(1.15, 1.15);
            }];
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonHeight - self.bottomLineHeight, self.bottomLineWidth, self.bottomLineHeight)];
            _lineView.x = segmentBtn.center.x - self.bottomLineWidth / 2.0f;
            _lineView.backgroundColor = self.bottomLineColor;
            
        }
        
        [self.headerView addSubview:segmentBtn];
        [_buttonArray addObject:segmentBtn];
    }
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.height - 1, self.buttonWidth * titleArray.count/*self.headerView.width*/, 1.f)];
    bottomLine.backgroundColor = [UIColor clearColor];
    
    [self.headerView addSubview:bottomLine];
    [self.headerView addSubview:_lineView];


}

/*!
 *  @brief  根据传入的viewController数组，将viewController的view添加到显示内容的scrollView
 *
 *  @param subViewControllers  viewController数组
 */
- (void)addContentViewScrollView:(NSArray *)subViewControllers
{
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.buttonHeight, _viewFrame.size.width, _viewFrame.size.height - self.buttonHeight)];
    _mainScrollView.contentSize = CGSizeMake(_viewFrame.size.width * subViewControllers.count, _viewFrame.size.height - self.buttonHeight );
    _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [_mainScrollView setPagingEnabled:YES];
    if (_segmentControlType == 0) {
        _mainScrollView.scrollEnabled = YES;
    }
    else {
        _mainScrollView.scrollEnabled = NO;
    }
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    [subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
//        if ([viewController isKindOfClass:[AssetsDetailTableViewController class]]) {
//            ((AssetsDetailTableViewController *)viewController).rowDelegate = self;
//        }
        viewController.view.frame = CGRectMake(idx * _viewFrame.size.width, 0, _viewFrame.size.width, _mainScrollView.frame.size.height);
        
        //        if ([viewController isKindOfClass:[BDTUserCollectionViewController class]]) {
        //            viewController.view.frame = CGRectMake(idx * _viewFrame.size.width, 0, _viewFrame.size.width, _mainScrollView.frame.size.height - 80);
        //        }
        [_mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

- (void)addParentController:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)btnClick:(UIButton *)button
{
    [_mainScrollView scrollRectToVisible:CGRectMake((button.tag - HEADBTN_TAG) *_viewFrame.size.width, 0, _viewFrame.size.width, _mainScrollView.frame.size.height) animated:YES];
    [self didSelectSegmentIndex:button.tag];
}

/*!
 *  @brief  设置顶部选中button下方线条位置
 *
 *  @param index 第几个
 */
- (void)didSelectSegmentIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
    btn.selected = NO;
    self.selectIndex = index;
    UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:index];
    currentSelectBtn.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        currentSelectBtn.transform = CGAffineTransformMakeScale(1.15, 1.15);
    }];
    
    
    CGRect rect = self.lineView.frame;
    rect.origin.x = currentSelectBtn.center.x - self.bottomLineWidth / 2.f;
//    rect.origin.x = (index - HEADBTN_TAG) * _buttonWidth;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = rect;
    }];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        float xx = scrollView.contentOffset.x * (_buttonWidth / _viewFrame.size.width) - _buttonWidth;
        [_headerView scrollRectToVisible:CGRectMake(xx, 0, _viewFrame.size.width, _headerView.frame.size.height) animated:YES];
        NSInteger currentIndex = scrollView.contentOffset.x / _viewFrame.size.width;
        [self.delegate slidePage:xx buttonTag:currentIndex + HEADBTN_TAG];
        [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    float xx = scrollView.contentOffset.x * (_buttonWidth / _viewFrame.size.width) - _buttonWidth;
    [_headerView scrollRectToVisible:CGRectMake(xx, 0, _viewFrame.size.width, _headerView.frame.size.height) animated:YES];
    
}

//跳转指定页面
- (void)jumpSpecifiedPage:(NSString *)title{
    if (!kStringIsEmpty(title)) {
        
        for (UIButton *btn in _buttonArray) {
            if ([btn.titleLabel.text isEqualToString:title]) {
                [self btnClick:btn];
                return ;
            }
        }
    }
}

#pragma mark - setter/getter
- (UIScrollView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIScrollView alloc] init];
        [_headerView setShowsVerticalScrollIndicator:NO];
        [_headerView setShowsHorizontalScrollIndicator:NO];
        _headerView.bounces = NO;
        _headerView.backgroundColor = self.headViewBackgroundColor;
    }
    return _headerView;
}

- (UIColor *)headViewBackgroundColor
{
    if (_headViewBackgroundColor == nil) {
        _headViewBackgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    }
    return _headViewBackgroundColor;
}

- (UIColor *)titleColor
{
    if (_titleColor == nil) {
        _titleColor = Default_SeletedTitleColor;
    }
    return _titleColor;
}

- (UIColor *)titleSelectedColor
{
    if (_titleSelectedColor == nil) {
        _titleSelectedColor = Default_TitleColor;
    }
    return _titleSelectedColor;
}

- (UIFont *)font{
    if (!_font) {
        _font = Default_Font;
    }
    return _font;
}

- (CGFloat)buttonWidth
{
    if (_buttonWidth == 0) {
        _buttonWidth = _viewFrame.size.width / 6;
    }
    return _buttonWidth;
}

- (CGFloat)buttonHeight
{
    if (_buttonHeight == 0) {
        _buttonHeight = Default_ButtonHeight;
    }
    return _buttonHeight;
}

- (CGFloat)bottomLineHeight
{
    if (_bottomLineHeight == 0) {
        _bottomLineHeight = Default_BottomLineHeight;
    }
    return _bottomLineHeight;
}

- (CGFloat)bottomLineWidth{
    if (_bottomLineWidth == 0) {
        _bottomLineWidth = self.buttonWidth;
    }
    return _bottomLineWidth;
}

- (UIColor *)bottomLineColor
{
    if (_bottomLineColor == nil) {
        _bottomLineColor = Default_BottomLineColor;
    }
    return _bottomLineColor;
}
//- (void)getRowNumber:(NSNotification *)noti{
//    NSInteger rowNumber = [noti.object integerValue];
//   CGRect frame = CGRectMake(0, 0, Screen_Width,  56 + rowNumber * 96);
//    CGSize scrollViewSize = _mainScrollView.contentSize;
//    scrollViewSize.height = frame.size.height - self.buttonHeight;
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
//}

@end
