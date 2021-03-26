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
//- (id)init {
//    if (self = [super init]) {
//        if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)])
//        {
//            self.extendedLayoutIncludesOpaqueBars = NO;
//        }
//        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//        {
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//        }
//        if([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)])
//        {
//            self.modalPresentationCapturesStatusBarAppearance = YES;
//        }
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.

    self.zx_navStatusBarStyle = ZXNavStatusBarStyleLight;
    self.zx_backBtnImageName = @"back";
    self.zx_navBarBackgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    self.zx_navLineViewBackgroundColor = [UIColor clearColor];
    self.zx_navItemMargin = 20;
    self.view.backgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setStatusBarBackgroundColor:nil];
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
