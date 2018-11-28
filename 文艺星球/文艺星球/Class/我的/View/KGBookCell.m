//
//  KGBookCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBookCell.h"

@implementation KGBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.changeEditStyle.constant = 0;
    self.chooseBtu.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)chooseAction:(UIButton *)sender {
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"weixuanzhong"]]) {
        [sender setImage:[UIImage imageNamed:@"fuhao"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}
- (void)starEdit{
    self.changeEditStyle.constant = 30;
    self.chooseBtu.hidden = NO;
}
- (void)endEdit{
    self.changeEditStyle.constant = 0;
    self.chooseBtu.hidden = YES;
}
/** 修改评分 */
- (void)changeStarWithScroe:(NSInteger)scroe{
    if (scroe < 1) {
        self.oneImage.image = [UIImage imageNamed:@"xingxing"];
        self.twoImage.image = [UIImage imageNamed:@"xingxing"];
        self.threeImage.image = [UIImage imageNamed:@"xingxing"];
        self.fourImage.image = [UIImage imageNamed:@"xingxing"];
        self.fiveImage.image = [UIImage imageNamed:@"xingxing"];
    }else if (scroe < 2){
        self.oneImage.image = [UIImage imageNamed:@"xing"];
        self.twoImage.image = [UIImage imageNamed:@"xingxing"];
        self.threeImage.image = [UIImage imageNamed:@"xingxing"];
        self.fourImage.image = [UIImage imageNamed:@"xingxing"];
        self.fiveImage.image = [UIImage imageNamed:@"xingxing"];
    }else if (scroe < 3){
        self.oneImage.image = [UIImage imageNamed:@"xing"];
        self.twoImage.image = [UIImage imageNamed:@"xing"];
        self.threeImage.image = [UIImage imageNamed:@"xingxing"];
        self.fourImage.image = [UIImage imageNamed:@"xingxing"];
        self.fiveImage.image = [UIImage imageNamed:@"xingxing"];
    }else if (scroe < 4){
        self.oneImage.image = [UIImage imageNamed:@"xing"];
        self.twoImage.image = [UIImage imageNamed:@"xing"];
        self.threeImage.image = [UIImage imageNamed:@"xing"];
        self.fourImage.image = [UIImage imageNamed:@"xingxing"];
        self.fiveImage.image = [UIImage imageNamed:@"xingxing"];
    }else if (scroe < 5){
        self.oneImage.image = [UIImage imageNamed:@"xing"];
        self.twoImage.image = [UIImage imageNamed:@"xing"];
        self.threeImage.image = [UIImage imageNamed:@"xing"];
        self.fourImage.image = [UIImage imageNamed:@"xing"];
        self.fiveImage.image = [UIImage imageNamed:@"xingxing"];
    }else{
        self.oneImage.image = [UIImage imageNamed:@"xing"];
        self.twoImage.image = [UIImage imageNamed:@"xing"];
        self.threeImage.image = [UIImage imageNamed:@"xing"];
        self.fourImage.image = [UIImage imageNamed:@"xing"];
        self.fiveImage.image = [UIImage imageNamed:@"xing"];
    }
}

@end
