//
//  WalletManageViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/27.
//

#import "WalletManageViewController.h"
#import "WalletManagerDetailTableViewController.h"
#import "WalletManagerTableViewCell.h"
#import "ImportAccountViewController.h"
#import "AddWalletTableViewController.h"

@interface WalletManageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *walletTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popViewTop;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@end

@implementation WalletManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zx_hideBaseNavBar = NO;
    kWeakSelf(self)
    [self zx_setRightBtnWithImgName:@"addWallet" clickedBlock:^(UIButton * _Nonnull btn) {

        [weakself showAlertView:YES];
    }];
    
    self.walletTableView.rowHeight = 56.f;
    _popView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePathWithName(USERACCOUNT)];
    
    _popViewTop.constant = ZXSafeAreaBottom;
    if(_dataArray.count == 0) [RpcRequest deleteFile:TRANSFERADDRESS];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showAlertView:NO];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellId = @"WalletManagerTableViewCell";
    WalletManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    UserInfoModel *model = _dataArray[indexPath.row];
    cell.model = model;
    kWeakSelf(self)
    [cell setBlock:^(UserInfoModel *model) {
        WalletManagerDetailTableViewController *detailTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletManagerDetailTableViewController"];
        detailTVC.model = model;
        [weakself.navigationController pushViewController:detailTVC animated:YES];
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < tableView.visibleCells.count; i ++) {
        WalletManagerTableViewCell *cell = (WalletManagerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selectImageView.image = i == indexPath.row ? [UIImage imageNamed:@"Seleted"] : [UIImage new];
    }
    
}
- (void)showAlertView:(BOOL)isShow{
  
    _popViewTop.constant = isShow ? -177: ZXSafeAreaBottom;
    _maskView.hidden = !isShow;
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)clickCreatButton:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddWalletTableViewController *addTVC = [storyboard instantiateViewControllerWithIdentifier:@"AddWalletTableViewController"];
    [self.navigationController pushViewController:addTVC animated:YES];
}
- (IBAction)clickImportButton:(UIButton *)sender {
    ImportAccountViewController *importVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportAccountViewController"];
    [self.navigationController pushViewController:importVC animated:YES];
}
- (IBAction)clickCancleButton:(UIButton *)sender {
    [self showAlertView:NO];
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
