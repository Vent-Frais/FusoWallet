//
//  MnemonicViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "MnemonicViewController.h"
#import "MnemonicCollectionViewCell.h"
#import "MnemonicCollectionReusableView.h"
#import "VerifyMnemonicTableViewController.h"

@interface MnemonicViewController ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *mnemonicCollectionView;
@property (strong, nonatomic) NSArray *mnemonicArray;

@end

@implementation MnemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMnemonicArray];
}
- (void)initMnemonicArray{
    NSString *mnemonicString = [[RpcRequest shared]CreatMnemonicString];
    _mnemonicArray = [mnemonicString componentsSeparatedByString:@" "];
    [self initCollectionView];
}
- (void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
   
        // 设置每个item的大小，
    flowLayout.estimatedItemSize = CGSizeMake(70, 32);
           //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
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
////组的头视图创建
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *collectionFootIdentifer = @"MnemonicCollectionReusableView";
//
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//
//            MnemonicCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionFootIdentifer forIndexPath:indexPath];
//
//            return footView;
//
//
//    }else{
//       return (UICollectionReusableView *)[NSNull null];
//    }
//
//
//
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//        return CGSizeMake(Screen_Width, 80);
//
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    VerifyMnemonicTableViewController *verifyVC = segue.destinationViewController;
    verifyVC.mnemonicArray = _mnemonicArray;
    
}


@end
