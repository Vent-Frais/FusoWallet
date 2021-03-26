//
//  CoinModel.h
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinModel : NSObject
@property (nonatomic, strong) NSString *coinName;
@property (nonatomic, strong) NSString *coinAmount;
@property (nonatomic, strong) NSString *coinMoneyAmount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *des;
+ (NSArray *)coinArray;
@end

NS_ASSUME_NONNULL_END

