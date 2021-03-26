//
//  MnemonicViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "MnemonicViewController.h"
#import "MnemonicCollectionViewCell.h"
#import "MnemonicCollectionReusableView.h"
#import "VerifyMnemonicViewController.h"
#import "JYEqualCellSpaceFlowLayout.h"

@interface MnemonicViewController ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *mnemonicCollectionView;
@property (strong, nonatomic) NSArray *mnemonicArray;

@end

@implementation MnemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMnemonicArray];
    NSString *title = _isBackup ? @"Backup mnemonic" : @"Your mnemonic";
    NSString *detail = _isBackup ? @"TPlease copy the mnemonic words in order to ensure that the backup is correct" : @"Write down or copy these words in the correct order and keep them in a safe place";
    _titleLabel.text = title;
    _detailLabel.text = detail;
}
- (void)initMnemonicArray{
    NSString *mnemonicString = [[RpcRequest shared]CreatMnemonicString];
    _mnemonicArray = [mnemonicString componentsSeparatedByString:@" "];
    [self initCollectionView];
}
- (void)initCollectionView{
    JYEqualCellSpaceFlowLayout *flowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithCenter betweenOfCell:8.0];
   
        // 设置每个item的大小，
    flowLayout.estimatedItemSize = CGSizeMake(70, 32);
 
    // 设置列的最小间距
 
    flowLayout.minimumInteritemSpacing = 8;
 
    // 设置最小行间距
 
    flowLayout.minimumLineSpacing = 16;
  
    // 设置布局的内边距
 
    flowLayout.sectionInset = UIEdgeInsetsMake(4, 8, 4, 8);
 
    // 滚动方向
 
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
   
    _mnemonicCollectionView.collectionViewLayout = flowLayout;
    
    [_mnemonicCollectionView reloadData];

//    [[[CommonData manager]showTView]addSubview:_filterCollectionView];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _mnemonicArray.count;
 
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *collectionViewCellId = @"MnemonicCollectionViewCell";
    MnemonicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellId forIndexPath:indexPath];
    
    NSString *mString = _mnemonicArray[indexPath.row];
    cell.mnemonic = mString;
    cell.indexString = [NSString stringWithFormat:@"%ld ",indexPath.row + 1];
    [cell showMnemonic];
      
    return cell;
      
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    VerifyMnemonicViewController *verifyVC = segue.destinationViewController;
    verifyVC.mnemonicArray = _mnemonicArray;
    verifyVC.walletName = _walletName;
    verifyVC.passphrase = _passphrase;
    verifyVC.isBackup = _isBackup;
    
}


@end
