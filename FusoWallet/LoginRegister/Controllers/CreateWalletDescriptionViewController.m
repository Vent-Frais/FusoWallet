//
//  CreateWalletDescriptionViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "CreateWalletDescriptionViewController.h"
#import "MnemonicViewController.h"

@interface CreateWalletDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *noticLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation CreateWalletDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _agreeButton.hidden = _isBackup;
    _noticLabel.hidden = _isBackup;
    _nextButton.selected = _isBackup;
    NSString *title = _isBackup ? @"Backup mnemonic" : @"Please back up your wallet immediately!";
    NSString *detail = _isBackup ? @"The mnemonic phrase is lost and cannot be retrieved, please make sure to back up the mnemonic phrase" : @"";
    _titleLabel.text = title;
    _detailLabel.text = detail;
}
- (IBAction)clickAgreeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _nextButton.selected = sender.selected;
}
- (IBAction)clickNextButton:(UIButton *)sender {
    if (_nextButton.selected) {
        MnemonicViewController *mnemonicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MnemonicViewController"];
        mnemonicVC.walletName = _walletName;
        mnemonicVC.passphrase = _passphrase;
        mnemonicVC.isBackup = _isBackup;
        [self.navigationController pushViewController:mnemonicVC animated:YES];
    }
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
