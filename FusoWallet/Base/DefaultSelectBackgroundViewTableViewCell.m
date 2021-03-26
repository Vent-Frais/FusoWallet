//
//  DefaultSelectBackgroundViewTableViewCell.m
//  IPFS
//
//  Created by Developer on 2020/10/5.
//  Copyright © 2020 Developer. All rights reserved.
//

#import "DefaultSelectBackgroundViewTableViewCell.h"

@implementation DefaultSelectBackgroundViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorNamed:@"CellSelectedColor"];
    self.selectedBackgroundView = selectionColor;
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"disclosureIndicator"]];
        imageView.frame = CGRectMake(0, 0, 16, 16);
        self.accessoryView = imageView;
    }
//    self.backgroundColor = [UIColor colorNamed:@"BackgroundColor"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
