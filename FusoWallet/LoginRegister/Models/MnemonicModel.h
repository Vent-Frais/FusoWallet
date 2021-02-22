//
//  MnemonicModel.h
//  FusoWallet
//
//  Created by Developer on 2021/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MnemonicModel : NSObject
@property (strong, nonatomic) NSString *mnemonic;
@property (assign, nonatomic) BOOL selectState;
@end

NS_ASSUME_NONNULL_END
