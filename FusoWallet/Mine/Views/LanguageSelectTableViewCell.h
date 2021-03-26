//
//  LanguageSelectTableViewCell.h
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import <UIKit/UIKit.h>
#import "LanguageSelectedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LanguageSelectTableViewCell : DefaultSelectBackgroundViewTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *languageNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (strong, nonatomic) LanguageSelectedModel *model;
@end

NS_ASSUME_NONNULL_END
