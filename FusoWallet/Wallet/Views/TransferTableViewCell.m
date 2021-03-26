//
//  TransferTableViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/2/24.
//

#import "TransferTableViewCell.h"

@implementation TransferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TransferCoinModel *)model{
    _model = model;
    _timeLabel.text = [RpcRequest timeIntervalToTimeString:_model.dateTime customDateFormat:nil];
    _directionLabel.text = _model.direction;
    _numberLabel.text = _model.coinAmount;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
