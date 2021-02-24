//
//  WithdrawViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/24.
//

#import "WithdrawViewController.h"

@interface WithdrawViewController ()
@property (weak, nonatomic) IBOutlet IQTextView *addressTextView;
@property (weak, nonatomic) IBOutlet IQTextView *amountTextView;
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
    [self zx_setRightBtnWithImgName:@"scan" clickedBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"点击了最右侧的Button");
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
