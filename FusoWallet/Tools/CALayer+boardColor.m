//
//  CALayer+boardColor.m
//  BeiDuoTravel
//
//  Created by admin on 2017/6/9.
//  Copyright © 2017年 BeiDuo. All rights reserved.
//

#import "CALayer+boardColor.h"

@implementation CALayer (boardColor)
- (void)setBoardUIColor:(UIColor *)boardUIColor{
    self.borderColor = boardUIColor.CGColor;
}
- (UIColor *)boardUIColor{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
