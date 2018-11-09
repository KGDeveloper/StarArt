//
//  KGAgencyDetailTableViewCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyDetailTableViewCell.h"

@implementation KGAgencyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)zansAction:(UIButton *)sender {
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
        [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }
}


@end
