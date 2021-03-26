//
//  NavView.h
//  FusoWallet
//
//  Created by Developer on 2021/2/25.
//
typedef void(^BackBlock)(void);
typedef void(^RightBlock)(void);
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavView : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (copy, nonatomic) BackBlock backBlock;
@property (copy, nonatomic) RightBlock rightBlock;

@end

NS_ASSUME_NONNULL_END
