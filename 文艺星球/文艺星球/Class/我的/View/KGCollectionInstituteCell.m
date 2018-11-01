//
//  KGCollectionInstituteCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGCollectionInstituteCell.h"

@implementation KGCollectionInstituteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.changeViewWidth.constant = 0;
    self.chooseBtu.hidden = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)starEdit{
    self.changeViewWidth.constant = 30;
    self.chooseBtu.hidden = NO;
}
- (void)endEdit{
    self.changeViewWidth.constant = 0;
    self.chooseBtu.hidden = YES;
}
- (IBAction)chooseCell:(UIButton *)sender {
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"weixuanzhong"]]) {
        [sender setImage:[UIImage imageNamed:@"fuhao"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}

@end
