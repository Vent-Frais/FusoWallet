//
//  AppDelegate.h
//  FusoWallet
//
//  Created by Developer on 2021/2/19.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
- (void)setRootVCToWallet;
- (void)setRootVCToLoginRegist;
@end

