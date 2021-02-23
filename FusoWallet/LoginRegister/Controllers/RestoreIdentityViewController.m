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
        NSString *mnemonic = _textView.text;
        NSLog(@"%@",mnemonic);
        NSArray *userArray = [RpcRequest getTheObjectForKey:USERACCOUNT];
        NSDictionary *dic = [[RpcRequest shared]fromMnemonicGetInfo:mnemonic passphrase:@""];
        UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:dic];
        if (!userArray) {

            NSString *fileName = [NSString stringWithFormat:@"%@.plist",model.address];
            if ([NSKeyedArchiver archiveRootObject:model toFile:FilePathWithName(fileName)]) {
                userArray = [NSArray arrayWithObject:model.address];
                [RpcRequest saveObjectForUser:userArray key:USERACCOUNT];
            }else{
                NSLog(@"存储错误");
            }
            
        }else{

            if (![userArray containsObject:model.address]) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:userArray];
                [array addObject:model.address];
                NSString *fileName = [NSString stringWithFormat:@"%@.plist",model.address];
                if([NSKeyedArchiver archiveRootObject:model toFile:FilePathWithName(fileName)]){
                  [RpcRequest saveObjectForUser:array.copy key:USERACCOUNT];
                }
                
            }
            
           
        }
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
