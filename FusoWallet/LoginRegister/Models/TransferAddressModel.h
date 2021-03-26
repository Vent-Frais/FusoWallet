//
//  TransferAddressModel.h
//  FusoWallet
//
//  Created by Developer on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransferAddressModel : NSObject
@property (strong, nonatomic) NSString *coinName;
@property (strong, nonatomic) NSString *transferAddress;
@property (strong, nonatomic) NSString *alias;
@property (strong, nonatomic) NSString *des;
@end
NS_ASSUME_NONNULL_END
