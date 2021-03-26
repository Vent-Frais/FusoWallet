//
//  WalletManagerTableViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/2/27.
//

#import "WalletManagerTableViewCell.h"

@implementation WalletManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(UserInfoModel *)model{
    _model = model;
    _selectImageView.image = _model.selected ? [UIImage imageNamed:@"Seleted"] : [UIImage new];
    _coinNameLabel.text = _model.walletName;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickDetailButton:(UIButton *)sender {
    if (self.block) {
        self.block(_model);
    }
}
@end
