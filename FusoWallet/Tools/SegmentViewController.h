//
//  SegmentViewController.h
//  SegmentView
//
//  Created by tom.sun on 16/5/26.
//  Copyright © 2016年 tom.sun. All rights reserved.
//
//#import "AssetsDetailTableViewController.h"
#import <UIKit/UIKit.h>
@protocol SildSelectDelegate <NSObject>
- (void)slidePage:(float)xx buttonTag:(NSInteger)tag;
@end
typedef NS_ENUM(NSInteger, SegmentHeaderType) {
    SegmentHeaderTypeScroll, //标签栏可滚动
    SegmentHeaderTypeFixed   //标签栏固定
};

typedef NS_ENUM(NSInteger, SegmentControlStyle) {
    SegmentControlTypeScroll, //内容部分可滚动
    SegmentControlTypeFixed   //内容部分固定
};

@interface SegmentViewController : UIViewController
//标签栏标题数组
@property (nonatomic, strong) NSArray *titleArray;
//每个标签对应ViewController数组
@property (nonatomic, strong) NSArray *subViewControllers;
//标签栏背景色
@property (nonatomic, strong) UIColor *headViewBackgroundColor;
//非选中状态下标签字体颜色
@property (nonatomic, strong) UIColor *titleColor;
//选中标签字体颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
//标签字体
@property (nonatomic, assign) UIFont *font;
//标签栏每个按钮高度
@property (nonatomic, assign) CGFloat buttonHeight;
//标签栏每个按钮宽度
@property (nonatomic, assign) CGFloat buttonWidth;
//选中标签下划线高度
@property (nonatomic, assign) CGFloat bottomLineHeight;
//选中标签下划线宽度
@property (nonatomic, assign) CGFloat bottomLineWidth;
//选中标签底部划线颜色
@property (nonatomic, strong) UIColor *bottomLineColor;
//标签栏类型，默认为滚动
@property (nonatomic, assign) SegmentHeaderType segmentHeaderType;
//内容类型，默认为滚动
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, assign) SegmentControlStyle segmentControlType;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) CGRect viewFrame;
@property (nonatomic,weak) id<SildSelectDelegate>delegate;

//初始化方法
- (void)initSegment;
//点击标签栏按钮调用方法
- (void)btnClick:(UIButton *)button;
- (void)didSelectSegmentIndex:(NSInteger)index;
- (void)addParentController:(UIViewController *)viewController;
- (void)jumpSpecifiedPage:(NSString *)title;
@end
