//
//  VerifyMnemonicViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/22.
//

#import "VerifyMnemonicViewController.h"
#import "MnemonicCollectionViewCell.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "UserInfoModel.h"

@interface VerifyMnemonicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *verifyMnemonicCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *disorderMnemonicCollectionView;
@property (strong, nonatomic) NSMutableArray *verifyMnemonicArray;
@property (strong, nonatomic) NSMutableArray *disorderMnemonicArray;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UILabel *perfectLabel;
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
 
    JYEqualCellSpaceFlowLayout *disorderFlowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithCenter betweenOfCell:8.0];
    JYEqualCellSpaceFlowLayout *verifyFlowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithCenter betweenOfCell:8.0];
   
        // 设置每个item的大小，
    disorderFlowLayout.estimatedItemSize = CGSizeMake(70, 32);
    verifyFlowLayout.estimatedItemSize = CGSizeMake(70, 32);
  
    // 设置列的最小间距
           
    disorderFlowLayout.minimumInteritemSpacing = 8;
    verifyFlowLayout.minimumInteritemSpacing = 8;
          
    // 设置最小行间距
        
    disorderFlowLayout.minimumLineSpacing = 8;
    verifyFlowLayout.minimumLineSpacing = 8;
      
    // 设置布局的内边距
      
    disorderFlowLayout.sectionInset = UIEdgeInsetsMake(12, 24, 8, 24);
    verifyFlowLayout.sectionInset = UIEdgeInsetsMake(12, 24, 8, 24);
    
    // 滚动方向
          
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
   
    _disorderMnemonicCollectionView.collectionViewLayout = disorderFlowLayout;
    _verifyMnemonicCollectionView.collectionViewLayout = verifyFlowLayout;
//    _verifyMnemonicCollectionView.collectionViewLayout = flowLayout;
    
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
    if (_verifyMnemonicArray.count == 12) {
        
        _completeButton.selected = [self comparisonMnemonic];
        _perfectLabel.hidden = !_completeButton.selected;
    }else{
        
        _completeButton.selected = NO;
        _perfectLabel.hidden = YES;
    }
}
- (BOOL)comparisonMnemonic{
    for (int i = 0; i < _verifyMnemonicArray.count; i ++) {
        NSString *verifym = _verifyMnemonicArray[i];
        NSString *m = _mnemonicArray[i];
        if (![verifym isEqualToString:m]) {
            return NO;
        }
    }
    return YES;
}
- (IBAction)clickCompleteButton:(UIButton *)sender {
    NSString *mnemonic = [_mnemonicArray componentsJoinedByString:@" "];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
