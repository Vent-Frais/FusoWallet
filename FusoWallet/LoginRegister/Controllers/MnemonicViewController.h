//
//  MnemonicViewController.h
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MnemonicViewController : BaseNavViewController
@property (nonatomic, strong) NSString *walletName;
@property (nonatomic, strong) NSString *passphrase;
@property (nonatomic, assign) BOOL isBackup;
@end

NS_ASSUME_NONNULL_END
