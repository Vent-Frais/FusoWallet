//
//  TransferCoinModel.h
//  FusoWallet
//
//  Created by Developer on 2021/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransferCoinModel : NSObject
@property (nonatomic, assign) long long dateTime;
@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *coinAmount;

@end

NS_ASSUME_NONNULL_END
