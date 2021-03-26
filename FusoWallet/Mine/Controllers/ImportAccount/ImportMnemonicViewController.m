//
//  ImportMnemonicViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import "ImportMnemonicViewController.h"

@interface ImportMnemonicViewController ()
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UILabel *noticLabel;
@property (weak, nonatomic) IBOutlet IQTextView *mnemonicTextView;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *mnemonicView;

@end

@implementation ImportMnemonicViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputStateChange:) name:UITextViewTextDidChangeNotification object:nil];
}
- (IBAction)clickCompleteButton:(UIButton *)sender {
    if (_completeButton.selected) {
        NSDictionary *dic = [[RpcRequest shared] fromMnemonicGetInfo:_mnemonicTextView.text passphrase:@""];
        NSLog(@"%@",dic);
    }
}
- (void)inputStateChange:(NSNotification *)noti{
    BOOL isShow = _mnemonicTextView.text.length > 0;
    
    _noticLabel.hidden = !isShow;
    _completeButton.selected = isShow;
    _mnemonicView.isChangeColor = isShow;
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
