//
//  AppDelegate.m
//  FusoWallet
//
//  Created by Developer on 2021/2/19.
//

#import "AppDelegate.h"
#import "UserInfoModel.h"
#import "LoginRegistViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSString *address = [RpcRequest getTheObjectForKey:Current_user_adress];
    if (address.length == 0) [self setRootVCToLoginRegist];
    
    return YES;
}
- (void)setRootVCToWallet{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *rootTBC = [storyboard instantiateViewControllerWithIdentifier:@"RootTBC"];
    self.window.rootViewController = rootTBC;
    [self.window makeKeyAndVisible];

}
- (void)setRootVCToLoginRegist{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZXNavigationBarController *rootVC= [storyboard instantiateViewControllerWithIdentifier:@"loginRegistSBID"];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}
//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
