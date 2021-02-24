//
//  WBQRCodeVC.h
//  SGQRCodeExample
//
//  Created by kingsic on 2018/2/8.
//  Copyright © 2018年 kingsic. All rights reserved.
//
@protocol scanTwoDimensionCodeDelegate <NSObject>

- (void)scanTwodimensionCodeResult:(NSString *)result;

@end
#import <UIKit/UIKit.h>

@interface WBQRCodeVC : UIViewController
@property (weak, nonatomic) id<scanTwoDimensionCodeDelegate>delegate;
@end
