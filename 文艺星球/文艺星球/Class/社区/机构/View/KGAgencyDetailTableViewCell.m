//
//  KGAgencyDetailTableViewCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyDetailTableViewCell.h"

@interface KGAgencyDetailTableViewCell ()

@property (nonatomic,copy) NSDictionary *userDic;

@end

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
    [KGRequest postWithUrl:UpPlaceCommentLikeStatusByCid parameters:@{@"cid":self.userDic[@"id"]} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
    
}
/** 数据填充 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    self.userDic = dic;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraituri"]]];
    self.timeLab.text = dic[@"commentTime"];
    self.detailLab.text = dic[@"comment"];
    self.nameLab.text = dic[@"username"];
    if (![dic[@"score"] isKindOfClass:[NSNull class]]) {
        if ([dic[@"score"] integerValue] < 2) {
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xingxing"];
            self.threeSatr.image = [UIImage imageNamed:@"xingxing"];
            self.fourStar.image = [UIImage imageNamed:@"xingxing"];
            self.fiveSatr.image = [UIImage imageNamed:@"xingxing"];
        }else if ([dic[@"score"] integerValue] < 3) {
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeSatr.image = [UIImage imageNamed:@"xingxing"];
            self.fourStar.image = [UIImage imageNamed:@"xingxing"];
            self.fiveSatr.image = [UIImage imageNamed:@"xingxing"];
        }else if ([dic[@"score"] integerValue] < 4) {
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeSatr.image = [UIImage imageNamed:@"xing"];
            self.fourStar.image = [UIImage imageNamed:@"xingxing"];
            self.fiveSatr.image = [UIImage imageNamed:@"xingxing"];
        }else if ([dic[@"score"] integerValue] < 5) {
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeSatr.image = [UIImage imageNamed:@"xing"];
            self.fourStar.image = [UIImage imageNamed:@"xing"];
            self.fiveSatr.image = [UIImage imageNamed:@"xingxing"];
        }else{
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeSatr.image = [UIImage imageNamed:@"xing"];
            self.fourStar.image = [UIImage imageNamed:@"xing"];
            self.fiveSatr.image = [UIImage imageNamed:@"xing"];
        }
    }
    if ([dic[@"likeStatus"] integerValue] == 0) {
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }else{
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }
    [self.zansBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"goodSum"]] forState:UIControlStateNormal];
}


@end
