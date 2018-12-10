//
//  KGNewsCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNewsCell.h"

@implementation KGNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)shareAction:(UIButton *)sender {
    
}
- (IBAction)commendAction:(UIButton *)sender {
    
}
- (IBAction)zansBtu:(UIButton *)sender {
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequest postWithUrl:AddNewsLikeStatusByUid parameters:@{@"nid":@(sender.tag),@"cnType":@"0"} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"操作成功"] hideAnimated:YES afterDelay:1];
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
}

- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    if (![dic[@"newsCover"] isKindOfClass:[NSNull class]]) {
        [self.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"newsCover"] componentsSeparatedByString:@"#"] firstObject]]];
    }
    self.detailLab.text = dic[@"newsTitle"];
    self.nameLab.text = dic[@"newsSource"];
    [self.zansBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"goodSum"]] forState:UIControlStateNormal];
    self.zansBtu.tag = [dic[@"nid"] integerValue];
    [self.commendBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"commentSum"]] forState:UIControlStateNormal];
    if ([dic[@"likeStatus"] integerValue] == 0) {
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }else{
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }
}


@end
