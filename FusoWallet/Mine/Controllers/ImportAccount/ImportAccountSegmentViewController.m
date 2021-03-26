//
//  ImportAccountSegmentViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import "ImportAccountSegmentViewController.h"
#import "SegmentViewController.h"
#import "ImportMnemonicViewController.h"
#import "ImportPrivateKeyViewController.h"
#import "ImportKeystoreViewController.h"


@interface ImportAccountSegmentViewController ()<SildSelectDelegate>
@property (strong, nonatomic) SegmentViewController *segmentVC;
@end

@implementation ImportAccountSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initSegmentVC];
}
- (void)initSegmentVC{

//    if (_segmentVC) {
//         for (UIViewController *vc in _segmentVC.childViewControllers) {
//
//            [vc willMoveToParentViewController:nil];
//
//            [vc removeFromParentViewController];
//
//           }
//        _segmentVC = nil;
//    }
    
    ImportMnemonicViewController *mnemonicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportMnemonicViewController"];
    ImportPrivateKeyViewController *privateKeycVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportPrivateKeyViewController"];
    ImportKeystoreViewController *keystoreVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportKeystoreViewController"];
    NSArray *vcsArray = @[mnemonicVC, privateKeycVC, keystoreVC];
    NSArray *titleArray = @[@"Mnemonic", @"Private Key", @"Keystore"];
    
    _segmentVC = [[SegmentViewController alloc]init];
    _segmentVC.titleArray = titleArray;
    _segmentVC.subViewControllers = vcsArray;
    _segmentVC.buttonWidth = Screen_Width / 3.f;
    _segmentVC.buttonHeight = 48;
    _segmentVC.font = [UIFont fontWithName:@"OPPOSans-M" size:16.f];
    _segmentVC.titleColor = [UIColor colorNamed:@"CommonGrayColor"];
    _segmentVC.titleSelectedColor = [UIColor colorNamed:@"CommonGreenColor"];
    _segmentVC.bottomLineColor = [UIColor colorNamed:@"CommonGreenColor"];
    _segmentVC.headViewBackgroundColor = [UIColor colorNamed:@"BackgroundColor"];
    _segmentVC.bottomLineWidth = Screen_Width / 3.0f;
    CGRect frame = CGRectMake(0, 0, Screen_Width, Screen_Height - 75 - ZXNavBarHeight - ZXSafeAreaBottom);
    _segmentVC.viewFrame = frame;
    _segmentVC.view.frame = frame;
    _segmentVC.delegate = self;
    [_segmentVC initSegment];
    [_segmentVC addParentController:self];
    
    
}
-(void)slidePage:(float)xx buttonTag:(NSInteger)tag{
    NSLog(@"xx = %f,tag = %ld",xx,(long)tag);
    
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
