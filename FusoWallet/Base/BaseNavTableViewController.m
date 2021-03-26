//
//  BaseNavTableViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "BaseNavTableViewController.h"

@interface BaseNavTableViewController ()

@end

@implementation BaseNavTableViewController
- (NavView *)navView{
    if (!_navView) {
        _navView = [[NSBundle mainBundle]loadNibNamed:@"NavView" owner:self options:nil].firstObject;
        kWeakSelf(self)
        [_navView setBackBlock:^{
                    [weakself.navigationController popViewControllerAnimated:YES];
        }];
        _navView.frame = CGRectMake(0, 0, Screen_Width, ZXNavBarHeightNotIncludeStatusBar);
    }
    return _navView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zx_navStatusBarStyle = ZXNavStatusBarStyleLight;
    self.zx_backBtnImageName = @"back";
    self.zx_navBarBackgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    self.zx_navLineViewBackgroundColor = [UIColor clearColor];
    self.zx_navItemMargin = 20;
    self.view.backgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    self.tableView.backgroundColor = [UIColor colorNamed:@"BackgroundColor"];
//    self.zx_hideBaseNavBar = YES;
//    self.zx_showSystemNavBar = YES;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    self.tableView.tableFooterView = [[UIView alloc]init];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:nil];
}
- (void)customNav{
    [self.navigationController.navigationBar addSubview:self.navView];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self setStatusBarBackgroundColor:[UIColor colorNamed:@"BackgroundColor"]];
}
- (void)removeCustomNav{
    [_navView removeFromSuperview];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self setStatusBarBackgroundColor:nil];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    if (@available(iOS 13.0, *)) {
        UIView *_customStatusBar = nil;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        for (UIView *subView in keyWindow.subviews) {
            if (subView.tag == 109090909) {
                _customStatusBar = subView;
            }
        }
        
        if (color) {//有颜色
            if (_customStatusBar) {//已经有自定义的StatusBar，那就直接设置颜色
                _customStatusBar.backgroundColor = color;
            } else {//没有那就添加一个，并且设置颜色
                UIView *statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
                statusBar.backgroundColor = color;
                statusBar.tag = 109090909;
                [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
            }
        } else {//没有颜色
            if (_customStatusBar) {//已经有自定义的StatusBar，那就设置成透明色
                _customStatusBar.backgroundColor = [UIColor clearColor];
            } else {//没有就不用管了
                
            }
        }

    } else {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = color;
        }
    }
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
            return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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
