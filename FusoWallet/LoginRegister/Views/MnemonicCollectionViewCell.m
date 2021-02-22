//
//  MnemonicCollectionViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "MnemonicCollectionViewCell.h"

@implementation MnemonicCollectionViewCell
- (void)showMnemonic{
    if (_indexString) {
       _mnemonicLabel.attributedText = [RpcRequest getString:_indexString andFontSize:14 firstFontColor:[UIColor colorNamed:@"CommonGReenColor50"] secondStr:_mnemonic andSecondFontSize:14 secondFontColor:[UIColor colorNamed:@"CommonGreenColor"]];
    }else{
        _mnemonicLabel.text = _mnemonic;
    }
}
@end
