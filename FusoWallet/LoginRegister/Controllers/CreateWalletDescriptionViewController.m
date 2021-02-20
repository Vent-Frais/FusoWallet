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

@end

@implementation CreateWalletDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickAgreeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _nextButton.selected = sender.selected;
}
- (IBAction)clickNextButton:(UIButton *)sender {
    if (_agreeButton.selected) {
        MnemonicViewController *mnemonicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MnemonicViewController"];
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
