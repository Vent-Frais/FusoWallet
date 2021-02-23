//
//  WalletTableViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import "WalletTableViewCell.h"

@implementation WalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(CoinModel *)model{
    _model = model;
    _coinNameLabel.text = _model.coinName;
    _coinImageView.image = [UIImage imageNamed:_model.coinName];
    _coinNumberLabel.text = _model.coinNumber;
    _coinMoneyNumberLabel.text = _model.coinMoneyNumber;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
