//
//  OutTableViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import "OutTableViewController.h"
#import "TransferTableViewCell.h"
#import "TransferCoinModel.h"

@interface OutTableViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation OutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TransferCoinModel *model = [[TransferCoinModel alloc]init];
    model.dateTime = [[NSDate date]timeIntervalSince1970];
    model.direction = @"Transfer Out";
    model.coinAmount = @"+888 TAO";
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 12; i ++) {
        [_dataArray addObject:model];
    }
    self.tableView.rowHeight = 72.f;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"OutTransferTableViewCell";
    TransferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    TransferCoinModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
