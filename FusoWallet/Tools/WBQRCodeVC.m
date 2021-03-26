//
//  WBQRCodeVC.m
//  SGQRCodeExample
//
//  Created by kingsic on 2018/2/8.
//  Copyright © 2018年 kingsic. All rights reserved.
//

#import "WBQRCodeVC.h"
#import <SGQRCode.h>

@interface WBQRCodeVC () {
    SGQRCodeObtain *obtain;
}
@property (nonatomic, strong) SGQRCodeScanView *scanView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL stop;
@end

@implementation WBQRCodeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    if (_stop) {
        [obtain startRunningWithBefore:nil completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)dealloc {
    NSLog(@"WBQRCodeVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor blackColor];
    obtain = [SGQRCodeObtain QRCodeObtain];
    
    [self setupQRCodeScan];
    [self setupNavigationBar];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.promptLabel];
}


- (void)setupQRCodeScan {
    kWeakSelf(self)

    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.openLog = YES;
    configure.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    // 这里只是提供了几种作为参考（共：13）；需什么类型添加什么类型即可
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    configure.metadataObjectTypes = arr;
    
    [obtain establishQRCodeObtainScanWithController:self configure:configure];
    [obtain startRunningWithBefore:^{
        
        [ISMessages showCardAlertWithTitle:NSLocalizedString(@"正在加载...", nil)
                    message:nil
                    duration:3.f
                    hideOnSwipe:YES
                    hideOnTap:YES
                    alertType:ISAlertTypeSuccess
                    alertPosition:ISAlertPositionTop
                    didHide:^(BOOL finished) {
                       NSLog(@"Alert did hide.");
                    }];
        
    } completion:^{
        [ISMessages hideAlertAnimated:YES];
    }];
    [obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        kStrongSelf(self)
        if (result) {
            [obtain stopRunning];
            self.stop = YES;
            [obtain playSoundName:@"SGQRCode.bundle/sound.caf"];
            [self.delegate scanTwodimensionCodeResult:result];

//            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//            jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
//            jumpVC.jump_URL = result;
//            [weakSelf.navigationController pushViewController:jumpVC animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)setupNavigationBar {
    self.zx_navTitle = NSLocalizedString(@"扫一扫", nil);
    self.zx_navTitleColor = [UIColor whiteColor];
    
    kWeakSelf(self)
    [self zx_setRightBtnWithText:NSLocalizedString(@"相册", nil) clickedBlock:^(UIButton * _Nonnull btn) {
        kStrongSelf(self)
        [self rightBarButtonItenAction];
    }];
   
}

- (void)rightBarButtonItenAction {
    kWeakSelf(self)

    [obtain establishAuthorizationQRCodeObtainAlbumWithController:nil];
    if (obtain.isPHAuthorization == YES) {
//        kStrongSelf(self)
//        [self.scanView removeTimer];
    }
    [obtain setBlockWithQRCodeObtainAlbumDidCancelImagePickerController:^(SGQRCodeObtain *obtain) {
//        kStrongSelf(self)
//        [self.view addSubview:self.scanView];
    }];
    [obtain setBlockWithQRCodeObtainAlbumResult:^(SGQRCodeObtain *obtain, NSString *result) {
        kStrongSelf(self)
        if (result == nil) {
            NSLog(NSLocalizedString(@"暂未识别出二维码", nil));
        } else {
//            if ([result hasPrefix:@"http"]) {
//                ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//                jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
//                jumpVC.jump_URL = result;
//                [weakSelf.navigationController pushViewController:jumpVC animated:YES];
                
//            } else {
//                ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//                jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
//                jumpVC.jump_bar_code = result;
//                [weakSelf.navigationController pushViewController:jumpVC animated:YES];
            [self.delegate scanTwodimensionCodeResult:result];
            [self.navigationController popViewControllerAnimated:YES];
            }
//        }
    }];
}

- (SGQRCodeScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
//        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectMake(0, ZXNavBarHeight, Screen_Width, Screen_Height - ZXNavBarHeight - ZXSafeAreaBottom)];
        // 静态库加载 bundle 里面的资源使用 SGQRCode.bundle/QRCodeScanLineGrid
        // 动态库加载直接使用 QRCodeScanLineGrid
        _scanView.scanImageName = @"QRCodeScanLineGrid";
        _scanView.scanAnimationStyle = ScanAnimationStyleGrid;
        _scanView.cornerLocation = CornerLoactionOutside;
        _scanView.cornerColor = [UIColor orangeColor];
    }
    return _scanView;
}
- (void)removeScanningView {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = NSLocalizedString(@"将二维码/条码放入框内, 即可自动扫描", nil);
    }
    return _promptLabel;
}

@end
