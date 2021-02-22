//
//  VerifyMnemonicViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/22.
//

#import "VerifyMnemonicViewController.h"
#import "MnemonicCollectionViewCell.h"

@interface VerifyMnemonicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *verifyMnemonicCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *disorderMnemonicCollectionView;
@property (strong, nonatomic) NSMutableArray *verifyMnemonicArray;
@property (strong, nonatomic) NSMutableArray *disorderMnemonicArray;
@end

@implementation VerifyMnemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _verifyMnemonicArray = @[].mutableCopy;
    _disorderMnemonicArray = @[].mutableCopy;
    [self initCollectionView];
}
- (void)initCollectionView{
    _verifyMnemonicCollectionView.delegate = self;
    _verifyMnemonicCollectionView.dataSource = self;
    _disorderMnemonicCollectionView.delegate = self;
    _disorderMnemonicCollectionView.dataSource = self;
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
   
    _disorderMnemonicCollectionView.collectionViewLayout = flowLayout;
    _verifyMnemonicCollectionView.collectionViewLayout = flowLayout;
    
    NSSet *mnemonicSet = [NSSet setWithArray:_mnemonicArray];
    _disorderMnemonicArray =  [mnemonicSet allObjects].mutableCopy;
    
    [_verifyMnemonicCollectionView reloadData];
    [_disorderMnemonicCollectionView reloadData];
    NSLog(@"original = %@",_mnemonicArray);
    NSLog(@"disorder  = %@",_disorderMnemonicArray);

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (collectionView == _verifyMnemonicCollectionView) {
        return _verifyMnemonicArray.count;
    }else{
        return _disorderMnemonicArray.count;
    }
    
 
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *verifyCollectionViewCellId = @"VerifyMnemonicCollectionViewCell";
    static NSString *disorderCollectionViewCellId = @"DisorderMnemonicCollectionViewCell";
    if (collectionView == _verifyMnemonicCollectionView) {
        MnemonicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:verifyCollectionViewCellId forIndexPath:indexPath];
        cell.mnemonic = _verifyMnemonicArray[indexPath.row];
        cell.indexString = [NSString stringWithFormat:@"%ld ",indexPath.row + 1];
        [cell showMnemonic];
        return cell;
        
    }else{
        MnemonicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:disorderCollectionViewCellId forIndexPath:indexPath];
        cell.mnemonic = _disorderMnemonicArray[indexPath.row];
        [cell showMnemonic];
        return  cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _verifyMnemonicCollectionView) {
        [_disorderMnemonicArray addObject:_verifyMnemonicArray[indexPath.row]];
        [_verifyMnemonicArray removeObjectAtIndex:indexPath.row];
       
    }else{
        [_verifyMnemonicArray addObject:_disorderMnemonicArray[indexPath.row]];
        [_disorderMnemonicArray removeObjectAtIndex:indexPath.row];
    }
    [_verifyMnemonicCollectionView reloadData];
    [_disorderMnemonicCollectionView reloadData];

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
