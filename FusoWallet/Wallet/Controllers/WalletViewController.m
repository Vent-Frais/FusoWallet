//
//  WalletViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import "WalletViewController.h"
#import "WalletTableViewCell.h"
#import "CoinDetailViewController.h"

@interface WalletViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zx_navBarBackgroundColor = [UIColor colorNamed:@"CommonGReenColor70"];
    [self zx_setLeftBtnWithImgName:@"Filter" clickedBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"点击了最右侧的Button");
    }];
    _dataArray = [NSMutableArray array];
    NSArray *array = [CoinModel coinArray];
    for (int i = 0; i < array.count; i ++) {
        CoinModel *model = [[CoinModel alloc]init];
        model.coinName = array[i];
        model.coinAmount = @"0.0000";
        model.coinMoneyAmount = @"=$ 0.0000";
        [_dataArray addObject:model];
    }
    _tableView.rowHeight = 72.f;
    [_tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"WalletTableViewCell";
    WalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    CoinModel *model = _dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"CoinDetailViewController"] animated:YES];
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
