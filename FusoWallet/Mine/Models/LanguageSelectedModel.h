//
//  LanguageSelectedModel.h
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanguageSelectedModel : NSObject
@property (strong, nonatomic) NSString *languageName;
@property (assign, nonatomic) BOOL selectState;
@end

NS_ASSUME_NONNULL_END
