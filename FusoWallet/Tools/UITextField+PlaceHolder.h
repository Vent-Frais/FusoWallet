//
//  UITextField+PlaceHolder.h
//  IPFS
//
//  Created by Developer on 2020/8/18.
//  Copyright © 2020 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (PlaceHolder)
- (void)placeholdColor:(UIColor *)color font:(UIFont *)font string:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
