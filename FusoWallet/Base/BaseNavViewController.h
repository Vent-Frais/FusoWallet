//
//  BaseNavViewController.h
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavViewController : ZXNavigationBarController
- (void)setStatusBarBackgroundColor:(nullable UIColor *)color;
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
