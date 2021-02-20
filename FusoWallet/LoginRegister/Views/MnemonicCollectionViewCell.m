//
//  MnemonicCollectionViewCell.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "MnemonicCollectionViewCell.h"

@implementation MnemonicCollectionViewCell
- (void)showMnemonic{
    if (_mnemonic && _indexString) {
       _mnemonicLabel.attributedText = [RpcRequest getString:_indexString andFontSize:14 firstFontColor:[UIColor colorNamed:@"CommonGReenColor50"] secondStr:_mnemonic andSecondFontSize:14 secondFontColor:[UIColor colorNamed:@"CommonGreenColor"]];
    }
}
@end
