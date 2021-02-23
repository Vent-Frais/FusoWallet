//
//  AppDelegate.m
//  FusoWallet
//
//  Created by Developer on 2021/2/19.
//

#import "AppDelegate.h"
#import "UserInfoModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSArray *userArray = [RpcRequest getTheObjectForKey:USERACCOUNT];
    for (int i = 0; i < userArray.count; i ++) {
        NSString *mnemonic = userArray[i];
        NSString *fileName = [NSString stringWithFormat:@"%@.plist",FilePathWithName(mnemonic)];
        UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        NSLog(@"%@",model.mnemonics);
    }
//    [UINavigationController zx_hideAllNavBar];
//
//        UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        DemoListViewController *vc = [[DemoListViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        window.rootViewController = nav;
//        [window makeKeyAndVisible];
//        self.window = window;
    
    return YES;
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
