//
//  WalletManagerDetailTableViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/27.
//

#import "WalletManagerDetailTableViewController.h"
#import "CreateWalletDescriptionViewController.h"

@interface WalletManagerDetailTableViewController ()
@property (strong, nonatomic) IBOutlet UIView *changeNamePopView;
@property (weak, nonatomic) IBOutlet UITextField *changeNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation WalletManagerDetailTableViewController
- (UIView *)changeNamePopView{
    return _changeNamePopView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.zx_showSystemNavBar = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self customNav];
    [self addView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self removeCustomNav];
    [_changeNamePopView removeFromSuperview];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self showView];
            break;
        case 1:{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CreateWalletDescriptionViewController *desVC = [storyboard instantiateViewControllerWithIdentifier:@"CreateWalletDescriptionViewController"];
            desVC.isBackup = YES;
            [self.navigationController pushViewController:desVC animated:YES];
        }
            break;
            
        default:
            break;
    }
   
    
}
- (IBAction)clickCancleButton:(UIButton *)sender {
    [self hideView];
}
- (IBAction)clickCompleteButton:(UIButton *)sender {
    _nameLabel.text = _changeNameTextField.text;
    [self hideView];
}


- (void)addView{

    self.changeNamePopView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    self.changeNamePopView.alpha = 0;
    [ZXMainWindow addSubview:self.changeNamePopView];
    
    
}
- (void)showView{
    _changeNameTextField.text = _nameLabel.text;
    [UIView animateWithDuration:0.3f animations:^{
        
        self->_changeNamePopView.alpha = 1;
    }];
}
- (void)hideView{
    [UIView animateWithDuration:0.3f animations:^{
        
        self->_changeNamePopView.alpha = 0;
    }];
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
