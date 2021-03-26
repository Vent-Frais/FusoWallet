//
//  LanguageSelectTableViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import "LanguageSelectTableViewCell.h"

@implementation LanguageSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LanguageSelectedModel *)model{
    _model = model;
    _languageNameLabel.text = _model.languageName;
    _selectImageView.image = model.selectState ? [UIImage imageNamed:@"Seleted"] : [[UIImage alloc]init];
}

@end
