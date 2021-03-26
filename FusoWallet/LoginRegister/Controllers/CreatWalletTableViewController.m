//
//  CreatWalletTableViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/3/5.
//

#import "CreatWalletTableViewController.h"
#import "CreateWalletDescriptionViewController.h"

@interface CreatWalletTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet IQTextView *nameTextView;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet IQTextView *passwordTextView;
@property (weak, nonatomic) IBOutlet UILabel *confirmPasswordLabel;
@property (weak, nonatomic) IBOutlet IQTextView *confirmPSWTextView;
@property (strong, nonatomic) IBOutlet UIButton *creatButton;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *walletNameView;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *passwordView;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *confirmPSWView;

@end

@implementation CreatWalletTableViewController
- (UIButton *)creatButton{
    return _creatButton;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.creatButton.frame = CGRectMake(24, Screen_Height - 48 - ZXSafeAreaBottom - 28, Screen_Width - 48, 48);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputText:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *userArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePathWithName(USERACCOUNT)];
    _nameTextView.text = [NSString stringWithFormat:@"Fusotao-%ld",userArray.count + 1];
    [ZXMainWindow addSubview:self.creatButton];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    _walletNameView.isChangeColor = _nameTextView.text.length !=0;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_creatButton removeFromSuperview];
}
- (void)inputText:(NSNotification *)noti{

    _nameLabel.hidden = _nameTextView.text.length == 0;
    _passwordLabel.hidden = _passwordTextView.text.length == 0 ;
    _confirmPasswordLabel.hidden = _confirmPSWTextView.text.length == 0;
    _walletNameView.isChangeColor = _nameTextView.text.length !=0;
    _passwordView.isChangeColor = _passwordTextView.text.length !=0;
    _confirmPSWView.isChangeColor = _confirmPSWTextView.text.length !=0;
    
    if (!_nameLabel.hidden && !_passwordLabel.hidden && !_confirmPasswordLabel.hidden) {
        _creatButton.selected = YES;
    }else{
        _creatButton.selected = NO;
    }
}
- (IBAction)clickCreatButton:(UIButton *)sender {
    if (_creatButton.selected) {
        if ([_passwordTextView.text isEqualToString:_confirmPSWTextView.text]) {
            CreateWalletDescriptionViewController *creatDesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateWalletDescriptionViewController"];
            creatDesVC.walletName = _nameTextView.text;
            creatDesVC.passphrase = _confirmPasswordLabel.text;
            [self.navigationController pushViewController:creatDesVC animated:YES];
        }else{
            [RpcRequest showMesage:@"Inconsistent passwords entered"];
        }
       
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
