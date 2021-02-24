//
//  CoinDetailViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/23.
//

#import "CoinDetailViewController.h"
#import "CoinDetailSegmentViewController.h"

@interface CoinDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *coinContainerView;

@end

@implementation CoinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    [_coinContainerView do_corner:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:@"CoinDetailSegmentViewController"]) {
        CoinDetailSegmentViewController *detailVC = segue.destinationViewController;
    //    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    //    CGFloat safeHeight = window.safeAreaInsets.bottom + window.safeAreaInsets.top;
        CGFloat height = Screen_Height - 265 - 48;
        detailVC.viewFrame = CGRectMake(0, 0, Screen_Width, height);
    }
 
}



@end
