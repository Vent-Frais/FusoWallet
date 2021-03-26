//
//  VerifyMnemonicViewController.h
//  FusoWallet
//
//  Created by Developer on 2021/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyMnemonicViewController : BaseNavViewController
@property (nonatomic, strong) NSString *walletName;
@property (nonatomic, strong) NSString *passphrase;
@property (strong, nonatomic) NSArray *mnemonicArray;
@property (nonatomic, assign) BOOL isBackup;
@end

NS_ASSUME_NONNULL_END
