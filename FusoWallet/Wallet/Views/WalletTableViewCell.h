//
//  WalletTableViewCell.h
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import <UIKit/UIKit.h>
#import "CoinModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalletTableViewCell : DefaultSelectBackgroundViewTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coinImageView;
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinMoneyNumberLabel;
@property (strong, nonatomic) CoinModel *model;
@end

NS_ASSUME_NONNULL_END
