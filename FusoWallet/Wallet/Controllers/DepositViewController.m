//
//  DepositViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/25.
//

#import "DepositViewController.h"

@interface DepositViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coinImageView;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [RpcRequest creatQRCode:@"0xd20e1eb8bb108260e88dc9ffd2ccf6d bfcbb9669" imagView:_codeImageView];
}

- (IBAction)clickCopyButton:(UIButton *)sender {
    if (_addressLabel.text.length == 0) {
        return;;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _addressLabel.text;
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
- (IBAction)clickShareButton:(UIButton *)sender {
    NSString *textToShare = _addressLabel.text;
    UIImage *imageToShare = _codeImageView.image;
    NSURL *urlToShare = [NSURL URLWithString:@"https://www.bitnexus.pro"];
    NSArray *items = @[urlToShare,textToShare,imageToShare];

    [self shareWithActivityItems:items];
}
- (void)shareWithActivityItems:(NSArray *)activityItems
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    // 根据需要指定不需要分享的平台
//    activityVC.excludedActivityTypes = @[UIActivityTypeMail,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
    
   
    activityVC.completionWithItemsHandler = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError){
        if (completed) {
            
        }else {
            
        }
    };
    //这儿一定要做iPhone与iPad的判断，因为这儿只有iPhone可以present，iPad需pop，所以这儿actVC.popoverPresentationController.sourceView = self.view;在iPad下必须有，不然iPad会crash，self.view你可以换成任何view，你可以理解为弹出的窗需要找个依托。
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            activityVC.popoverPresentationController.sourceView = vc.view;
            activityVC.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height, 0, 0);
            [vc presentViewController:activityVC animated:YES completion:nil];
        }else{
            [vc presentViewController:activityVC animated:YES completion:nil];
        }

//    [self presentViewController:activityVC animated:YES completion:nil];
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
