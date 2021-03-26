//
//  UITextField+placeholder.m
//  IPFS
//
//  Created by Developer on 2020/8/18.
//  Copyright © 2020 Developer. All rights reserved.
//

#import "UITextField+PlaceHolder.h"

@implementation UITextField (PlaceHolder)
- (void)placeholdColor:(UIColor *)color font:(UIFont *)font string:(NSString *)string{
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:string];
   
    [placeholder addAttribute:NSForegroundColorAttributeName
                      value:color
                      range:NSMakeRange(0, string.length)];
    [placeholder addAttribute:NSFontAttributeName
                      value:font
                      range:NSMakeRange(0, string.length)];
    self.attributedPlaceholder = placeholder;
}
@end
