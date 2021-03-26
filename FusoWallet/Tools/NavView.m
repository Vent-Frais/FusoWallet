//
//  NavView.m
//  FusoWallet
//
//  Created by Developer on 2021/2/25.
//

#import "NavView.h"

@implementation NavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)clickLeftButton:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}
- (IBAction)clickRightButton:(UIButton *)sender {
    if (self.rightBlock) {
        self.rightBlock();
    }
}

@end
