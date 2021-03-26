//
//  CreatAddressBookTableViewController.h
//  FusoWallet
//
//  Created by Developer on 2021/2/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddressBookBlock)(NSMutableDictionary *_Nullable dic,BOOL isHide);
@interface CreatAddressBookTableViewController : BaseNavTableViewController
@property (weak, nonatomic) TransferAddressModel *model;
@property (nonatomic, copy) AddressBookBlock block;
@end

NS_ASSUME_NONNULL_END
