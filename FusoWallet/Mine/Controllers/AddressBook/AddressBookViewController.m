//
//  AddressBookViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/25.
//

#import "AddressBookViewController.h"
#import "AddressBookTableViewCell.h"
#import "CreatAddressBookTableViewController.h"

@interface AddressBookViewController ()
@property (weak, nonatomic) IBOutlet UITableView *addressBookTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popViewTop;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) TransferAddressModel *selectModel;
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zx_hideBaseNavBar = NO;
    _dataArray = @[].mutableCopy;
    kWeakSelf(self)
    [self zx_setRightBtnWithImgName:@"addWallet" clickedBlock:^(UIButton * _Nonnull btn) {
        CreatAddressBookTableViewController *creatABTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatAddressBookTableViewController"];
        [weakself.navigationController pushViewController:creatABTVC animated:YES];
    }];
    self.addressBookTableView.estimatedRowHeight = 100;
    self.addressBookTableView.rowHeight = UITableViewAutomaticDimension;
//    self.zx_navEnableSmoothFromSystemNavBar = YES;
    _popView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [_addressBookTableView registerNib:[UINib nibWithNibName:@"NoDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoDataTableViewCell"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableArray *userInfoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePathWithName(USERACCOUNT)];
    
    if(userInfoArray.count == 0){
        [RpcRequest deleteFile:TRANSFERADDRESS];
        return;
    }
    _dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePathWithName(TRANSFERADDRESS)];
    
    _popViewTop.constant = ZXSafeAreaBottom;
    [_addressBookTableView reloadData];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _popViewTop.constant = ZXSafeAreaBottom;
    [self showAlertView:NO];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count == 0) {
        return 1;
    }else{
        return _dataArray.count;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"AddressBookTableViewCell";
    static NSString *nodataId = @"NoDataTableViewCell";
    if (_dataArray.count == 0) {
        NoDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nodataId];
        return cell;
    }else{
        AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        TransferAddressModel *model = _dataArray[indexPath.row];
        
        cell.model = model;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArray.count == 0) {
        return _addressBookTableView.height;
    }else{
        return UITableViewAutomaticDimension;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectModel = _dataArray[indexPath.row];
    if (_isTransfer) {
        
    }else{
      [self showAlertView:YES];
    }
}
- (void)showAlertView:(BOOL)isShow{
  
    _popViewTop.constant = isShow ? -177: ZXSafeAreaBottom;
    _maskView.hidden = !isShow;
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)clickCopyButton:(UIButton *)sender {
    [self showAlertView:NO];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _selectModel.transferAddress;
    [ISMessages showCardAlertWithTitle:NSLocalizedString(@"复制成功", nil)
                message:nil
                duration:1.2f
                hideOnSwipe:YES
                hideOnTap:YES
                alertType:ISAlertTypeSuccess
                alertPosition:ISAlertPositionTop
                didHide:^(BOOL finished) {
                   NSLog(@"Alert did hide.");
    }];
    
}
- (IBAction)clickEditButton:(UIButton *)sender {
    [self showAlertView:NO];
    CreatAddressBookTableViewController *creatABTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatAddressBookTableViewController"];
    creatABTVC.model = _selectModel;
    [self.navigationController pushViewController:creatABTVC animated:YES];
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
