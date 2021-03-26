//
//  WalletManagerTableViewCell.h
//  FusoWallet
//
//  Created by Developer on 2021/2/27.
//
typedef void(^PushWalletDetailBlock)(UserInfoModel *_Nonnull);
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletManagerTableViewCell : DefaultSelectBackgroundViewTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (copy, nonatomic) PushWalletDetailBlock block;
@property (strong, nonatomic) UserInfoModel *model;
@end

NS_ASSUME_NONNULL_END
