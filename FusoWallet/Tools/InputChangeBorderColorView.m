//
//  InputChangeBorderColorView.m
//  FusoWallet
//
//  Created by Developer on 2021/3/23.
//

#import "InputChangeBorderColorView.h"

@implementation InputChangeBorderColorView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.boardUIColor = [UIColor colorNamed:@"BorderColor"];
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 16.f;
}

- (void)setIsChangeColor:(BOOL)isChangeColor{
    self.layer.boardUIColor = isChangeColor ? [UIColor colorNamed:@"CommonGreenColor"] : [UIColor colorNamed:@"BorderColor"];
}
@end
