//
//  MnemonicModel.h
//  FusoWallet
//
//  Created by Developer on 2021/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject
@property (strong, nonatomic) NSString *mnemonics;
@property (strong, nonatomic) NSString *privateKey;
@property (strong, nonatomic) NSString *publicKey;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSData *accoutId;
@property (strong, nonatomic) NSNumber *type;
@property (strong, nonatomic) NSData *keypair;

@end

NS_ASSUME_NONNULL_END

