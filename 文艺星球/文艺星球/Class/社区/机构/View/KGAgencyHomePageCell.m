//
//  KGAgencyHomePageCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyHomePageCell.h"

@implementation KGAgencyHomePageCell

/** 内容填充 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"image"] componentsSeparatedByString:@"#"] firstObject]]];
    self.nameLab.text = dic[@"username"];
    self.distanceLab.text = [NSString stringWithFormat:@"%@km",dic[@"distance"]];
    self.addressLab.text = dic[@"address"];
    self.detailLab.text = dic[@"blurb"];
    if (![dic[@"merchantsScore"] isKindOfClass:[NSNull class]]) {
        self.scoreLab.text = [NSString stringWithFormat:@"%@",dic[@"merchantsScore"]];
        if ([dic[@"merchantsScore"] integerValue] < 2) {
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xingxing"];
            self.threeStar.image = [UIImage imageNamed:@"xingxing"];
            self.fourStar.image = [UIImage imageNamed:@"xingxing"];
            self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
        }else if ([dic[@"merchantsScore"] integerValue] < 3){
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeStar.image = [UIImage imageNamed:@"xingxing"];
            self.fourStar.image = [UIImage imageNamed:@"xingxing"];
            self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
        }else if ([dic[@"merchantsScore"] integerValue] < 4){
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeStar.image = [UIImage imageNamed:@"xing"];
            self.fourStar.image = [UIImage imageNamed:@"xingxing"];
            self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
        }else if ([dic[@"merchantsScore"] integerValue] < 5){
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeStar.image = [UIImage imageNamed:@"xing"];
            self.fourStar.image = [UIImage imageNamed:@"xing"];
            self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
        }else{
            self.oneStar.image = [UIImage imageNamed:@"xing"];
            self.twoStar.image = [UIImage imageNamed:@"xing"];
            self.threeStar.image = [UIImage imageNamed:@"xing"];
            self.fourStar.image = [UIImage imageNamed:@"xing"];
            self.fiveStar.image = [UIImage imageNamed:@"xing"];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
