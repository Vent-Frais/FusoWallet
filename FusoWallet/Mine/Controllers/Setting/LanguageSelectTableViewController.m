//
//  LanguageSelectTableViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/3/1.
//

#import "LanguageSelectTableViewController.h"
#import "LanguageSelectTableViewCell.h"
#import "LanguageSelectedModel.h"

@interface LanguageSelectTableViewController ()
@property (nonatomic, strong) NSMutableArray *languageDataArray;
@end

@implementation LanguageSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.zx_showSystemNavBar = YES;
    NSArray *dataArray = @[
    @{@"languageName":@"English",@"selectState":@(YES)},
    @{@"languageName":@"简体中文",@"selectState":@(NO)},
    @{@"languageName":@"한국어",@"selectState":@(NO)},
    @{@"languageName":@"日本語",@"selectState":@(NO)},
    @{@"languageName":@"русский",@"selectState":@(NO)},
    @{@"languageName":@"Español",@"selectState":@(NO)}
    ];
    _languageDataArray = [LanguageSelectedModel mj_objectArrayWithKeyValuesArray:dataArray];
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self customNav];
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self removeCustomNav];
//}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _languageDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellId = @"LanguageSelectTableViewCell";
    LanguageSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    LanguageSelectedModel *model = _languageDataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i = 0; i < _languageDataArray.count; i ++) {
        LanguageSelectedModel *model = _languageDataArray[i];
        model.selectState = i == indexPath.row ? YES : NO;
    }
    [self.tableView reloadData];
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
