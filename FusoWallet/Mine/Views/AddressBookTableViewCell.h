//
//  AddressBookTableViewCell.h
//  FusoWallet
//
//  Created by Developer on 2021/2/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookTableViewCell : DefaultSelectBackgroundViewTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coinImageView;
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (strong, nonatomic) TransferAddressModel *model;
@end

NS_ASSUME_NONNULL_END
