//
//  TransferTableViewCell.h
//  FusoWallet
//
//  Created by Developer on 2021/2/24.
//

#import <UIKit/UIKit.h>
#import "TransferCoinModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransferTableViewCell : DefaultSelectBackgroundViewTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) TransferCoinModel *model;
@end

NS_ASSUME_NONNULL_END
