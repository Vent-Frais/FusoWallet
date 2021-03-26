//
//  WithdrawViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/24.
//

#import "WithdrawViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WBQRCodeVC.h"

@interface WithdrawViewController ()<scanTwoDimensionCodeDelegate>
@property (weak, nonatomic) IBOutlet IQTextView *addressTextView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet IQTextView *amountTextView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation WithdrawViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.addressTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    kWeakSelf(self)
    [self zx_setRightBtnWithImgName:@"scan" clickedBlock:^(UIButton * _Nonnull btn) {
        kStrongSelf(self)
        WBQRCodeVC *WCVC = [[WBQRCodeVC alloc] init];
        WCVC.delegate = self;
        [self QRCodeScanVC:WCVC];
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputComplete:) name:UITextViewTextDidChangeNotification object:nil];
}
- (IBAction)clickAllButton:(UIButton *)sender {
}
- (IBAction)clickNextButton:(UIButton *)sender {
    if (_nextButton.selected) {
        
    }
}
- (void)inputComplete:(NSNotification *)noti{
    if (_addressTextView.text.length > 0 && _amountTextView.text.length > 0) {
        _nextButton.selected = YES;
    }else{
        _nextButton.selected = NO;
    }
    _addressLabel.hidden = _addressTextView.text.length == 0 ? YES : NO;
    _amountLabel.hidden = _amountTextView.text.length == 0 ? YES : NO;
}

#pragma mark - KVO

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//
//    if ([keyPath isEqualToString:@"contentSize"]){
//        UITextView *tv = object;
//        CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
//        CGFloat inset = MAX(0, deadSpace/2.0);
//        tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
//    }
//}
#pragma mark ----QRDelegate----
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
                case AVAuthorizationStatusNotDetermined: {
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                        if (granted) {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                [self.navigationController pushViewController:scanVC animated:YES];
                            });
                            NSLog(NSLocalizedString(@"用户第一次同意了访问相机权限 - - %@", nil), [NSThread currentThread]);
                        } else {
                            NSLog(NSLocalizedString(@"用户第一次拒绝了访问相机权限 - - %@", nil), [NSThread currentThread]);
                        }
                    }];
                    break;
                }
                case AVAuthorizationStatusAuthorized: {
                    [self.navigationController pushViewController:scanVC animated:YES];
                    break;
                }
                case AVAuthorizationStatusDenied: {
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil) message:NSLocalizedString(@"请去-> [设置 - 隐私 - 相机 - Bitnexus] 打开访问开关", nil) preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *alertA = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    [alertC addAction:alertA];
                    [self presentViewController:alertC animated:YES completion:nil];
                    break;
                }
                case AVAuthorizationStatusRestricted: {
                    NSLog(NSLocalizedString(@"因为系统原因, 无法访问相册", nil));
                    break;
                }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil) message:NSLocalizedString(@"未检测到您的摄像头", nil) preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}
- (void)scanTwodimensionCodeResult:(NSString *)result{
    _addressTextView.text = result;
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
