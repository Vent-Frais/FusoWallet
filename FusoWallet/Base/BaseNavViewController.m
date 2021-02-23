//
//  BaseNavViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zx_navStatusBarStyle = ZXNavStatusBarStyleLight;
    self.zx_backBtnImageName = @"back";
    self.zx_navBarBackgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    self.zx_navLineViewBackgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
