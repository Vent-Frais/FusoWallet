//
//  RestoreIdentityViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import "RestoreIdentityViewController.h"

@interface RestoreIdentityViewController ()
@property (weak, nonatomic) IBOutlet IQTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *restoreButton;

@end

@implementation RestoreIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}
- (IBAction)clickRestoreButton:(UIButton *)sender {
    if (sender.selected) {
        
    }
}
- (void)textChange:(NSNotification *)noti{
    NSArray *textArray = [_textView.text componentsSeparatedByString:@" "];
    _restoreButton.selected = textArray.count == 12;
        
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
