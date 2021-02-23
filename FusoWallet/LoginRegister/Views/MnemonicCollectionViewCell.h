//
//  MnemonicCollectionViewCell.h
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MnemonicCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *mnemonicLabel;
@property (strong, nonatomic) NSString *mnemonic;
@property (strong, nonatomic) NSString *indexString;
- (void)showMnemonic;
@end

NS_ASSUME_NONNULL_END
