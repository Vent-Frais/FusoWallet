//
//  AppDelegate.h
//  SearchBar
//
//  Created by Jie Peng on 15/2/4.
//  Copyright (c) 2015年 Jie Peng. All rights reserved.
//


#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)MaxY
{
        return CGRectGetMaxY(self.frame);
}

- (CGFloat)MaxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)do_center
{
    UIView *superView = self.superview;
    self.x = (superView.width - self.width) / 2;
    self.y = (superView.height - self.height) / 2;
}

- (void)do_subview_center
{
    NSInteger count = self.subviews.count;
    int widthCount = 0;
    for (int i = 0; i < count; i++) {
        widthCount+=self.subviews[i].width;
    }
    CGFloat space = (self.width - widthCount)/count;
    int lastX = 0;
    for (int i = 0; i < count; i++) {
        if(i == 0)
        {
            self.subviews[i].x = 0;
        }else{
            self.subviews[i].x = space + lastX;
        }
        lastX = CGRectGetMaxX(self.subviews[i].frame);
    }
}
- (void)do_superShadow{
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
//    self.clipsToBounds = NO;
}
- (void)do_subShadow{
    for (UIView *subView in self.subviews) {
        subView.layer.cornerRadius = 4;
        subView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        subView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        subView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        subView.layer.shadowRadius = 4;//阴影半径，默认3
        //    subView.clipsToBounds = NO;

    }
    
}
- (void)do_layerShadow{
    self.layer.cornerRadius = 4;
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
//    self.layer.masksToBounds = YES;
}
- (void)do_corner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    
    if (!corners) {
        corners = UIRectCornerAllCorners;
    }
//    CGSizeMake(4,4)
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];//self.bounds.size
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

@end
