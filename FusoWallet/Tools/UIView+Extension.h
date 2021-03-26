//
//  AppDelegate.h
//  SearchBar
//
//  Created by Jie Peng on 15/2/4.
//  Copyright (c) 2015年 Jie Peng. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, readonly) CGFloat MaxY;
@property (nonatomic, readonly) CGFloat MaxX;

- (void)do_center;
- (void)do_subview_center;
- (void)do_superShadow;
- (void)do_subShadow;
- (void)do_corner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


@end
