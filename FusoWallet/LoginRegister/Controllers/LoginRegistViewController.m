//
//  LoginRegistViewController.m
//  FusoWallet
//
//  Created by Developer on 2021/2/20.
//

#import "LoginRegistViewController.h"
#import "ImportAccountViewController.h"

@interface LoginRegistViewController ()

@end

@implementation LoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zx_hideBaseNavBar = YES;
}
- (IBAction)clickAddWallet:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    ImportAccountViewController *importVC = [storyboard instantiateViewControllerWithIdentifier:@"ImportAccountViewController"];
    [self.navigationController pushViewController:importVC animated:YES];
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
