//
//  ImportKeystoreViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import "ImportKeystoreViewController.h"

@interface ImportKeystoreViewController ()
@property (weak, nonatomic) IBOutlet IQTextView *keystoreTextView;
@property (weak, nonatomic) IBOutlet UILabel *noticLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet InputChangeBorderColorView *keystoreView;
@end

@implementation ImportKeystoreViewController
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
        
    }
}
- (void)inputStateChange:(NSNotification *)noti{
    
    BOOL isShow = _keystoreTextView.text.length > 0;
    
    _noticLabel.hidden = !isShow;
    _completeButton.selected = isShow;
    _keystoreView.isChangeColor = isShow;
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
