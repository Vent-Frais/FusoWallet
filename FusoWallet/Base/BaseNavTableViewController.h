//
//  BaseNavTableViewController.h
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import <UIKit/UIKit.h>
#import "NavView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavTableViewController : ZXNavigationBarTableViewController
@property (nonatomic, strong) NavView *navView;
- (void)customNav;
- (void)removeCustomNav;
- (void)setStatusBarBackgroundColor:(UIColor *)color;
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
