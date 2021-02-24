//
//  CoinDetailSegmentViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import "CoinDetailSegmentViewController.h"
#import "SegmentViewController.h"
#import "AllTableViewController.h"
#import "InTableViewController.h"
#import "OutTableViewController.h"
@interface CoinDetailSegmentViewController ()
@property (strong, nonatomic) SegmentViewController *segmentVC;
@end

@implementation CoinDetailSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self initSegmentVC:nil];
}
- (void)initSegmentVC:(NSArray *)ary{
    if (_segmentVC) {
         for (UIViewController *vc in _segmentVC.childViewControllers) {

            [vc willMoveToParentViewController:nil];

            [vc removeFromParentViewController];

           }
        _segmentVC = nil;
    }

    AllTableViewController *allTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AllTableViewController"];
    InTableViewController *inTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InTableViewController"];
    OutTableViewController *outTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OutTableViewController"];
    NSMutableArray  *modelArray = [NSMutableArray array];
   

//    hotTVC.dataArray = modelArray;
//    turnoverTVC.dataArray = modelArray;
//    recentlTVC.dataArray = modelArray;
//    if (self.block) {
//        self.block(modelArray.count);
//    }
    NSString *allStr = NSLocalizedString(@"All", nil);
    NSString *inStr = NSLocalizedString(@"In", nil);
    NSString *outStr = NSLocalizedString(@"Out", nil);
    _segmentVC = [[SegmentViewController alloc]init];
    _segmentVC.titleArray = @[allStr,inStr,outStr];
    _segmentVC.subViewControllers = @[allTVC,inTVC,outTVC];
    _segmentVC.buttonWidth = Screen_Width / 3.f;
    
    _segmentVC.viewFrame = _viewFrame;
    
    [_segmentVC initSegment];
    [_segmentVC addParentController:self];

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
