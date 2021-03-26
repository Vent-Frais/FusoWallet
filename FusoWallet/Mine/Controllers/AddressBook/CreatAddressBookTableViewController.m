//
//  CreatAddressBookTableViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/26.
//

#import "CreatAddressBookTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WBQRCodeVC.h"


@interface CreatAddressBookTableViewController ()<scanTwoDimensionCodeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (weak, nonatomic) IBOutlet IQTextView *coinTextView;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property (weak, nonatomic) IBOutlet IQTextView *addressTextView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet IQTextView *nameTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet IQTextView *desTextView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *coinView;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *addressView;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *nameView;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *desView;
@property (strong, nonatomic) NSMutableDictionary *saveDic;
@end

@implementation CreatAddressBookTableViewController

- (UIButton *)saveButton{
    return _saveButton;
}
- (UIButton *)deleteButton{
    return _deleteButton;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zx_navFixHeight = ZXNavBarHeight;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputText:) name:UITextViewTextDidChangeNotification object:nil];
    self.saveButton.frame = CGRectMake(24, Screen_Height - ZXSafeAreaBottom - 28 - 48, Screen_Width - 48, 48);
    self.deleteButton.frame = self.saveButton.frame;
    _saveDic = @{}.mutableCopy;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _addressTitleLabel.text = _model ? @"Edit address" : @"New address ";
    
    [ZXMainWindow addSubview: _model ? self.deleteButton : self.saveButton];
    if (_model) {
        _coinTextView.text = _model.coinName;
        _addressTextView.text = _model.transferAddress;
        _nameTextView.text= _model.alias;
        _desTextView.text = _model.des;
        [self inputText:nil];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.saveButton removeFromSuperview];
    [self.deleteButton removeFromSuperview];
}
- (void)inputText:(NSNotification *)noti{

    _coinLabel.hidden = _coinTextView.text.length == 0;
    _coinView.isChangeColor = _coinTextView.text.length != 0;
    _addressLabel.hidden = _addressTextView.text.length == 0;
    _addressView.isChangeColor = _addressTextView.text.length != 0;
    _nameLabel.hidden = _nameTextView.text.length == 0;
    _nameView.isChangeColor = _nameTextView.text.length != 0;
    _desLabel.hidden = _desTextView.text.length == 0;
    _desView.isChangeColor = _desTextView.text.length != 0;
    
    _saveDic[@"coinName"] = _coinTextView.text;
    _saveDic[@"transferAddress"] = _addressTextView.text;
    _saveDic[@"alias"] = _nameTextView.text;
    _saveDic[@"des"] = _desTextView.text;
    BOOL isHide = _coinTextView.text.length > 0 && _addressTextView.text.length > 0 && _nameTextView.text.length > 0;
    self.saveButton.selected = isHide;
    
}
- (IBAction)clickQRButton:(UIButton *)sender {
    WBQRCodeVC *WCVC = [[WBQRCodeVC alloc] init];
    WCVC.delegate = self;
    [self QRCodeScanVC:WCVC];
}
- (IBAction)clickSaveButton:(UIButton *)sender {
    if (_saveButton.selected) {
        NSMutableArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePathWithName(TRANSFERADDRESS)];
        if (!dataArray) dataArray = @[].mutableCopy;
        TransferAddressModel *model = [TransferAddressModel mj_objectWithKeyValues:_saveDic];
        [dataArray addObject:model];
        [NSKeyedArchiver archiveRootObject:dataArray toFile:FilePathWithName(TRANSFERADDRESS)];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

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
