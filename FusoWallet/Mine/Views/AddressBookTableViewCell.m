//
//  AddressBookTableViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/2/25.
//

#import "AddressBookTableViewCell.h"

@implementation AddressBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(TransferAddressModel *)model{
    _model = model;
    _coinNameLabel.text = model.coinName;
    _addressLabel.text = model.transferAddress;
    _desLabel.text = model.des;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
