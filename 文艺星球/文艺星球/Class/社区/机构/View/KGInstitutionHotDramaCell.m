//
//  KGInstitutionHotDramaCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionHotDramaCell.h"

@implementation KGInstitutionHotDramaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"showCover"] componentsSeparatedByString:@"#"]firstObject]]];
    self.nameLab.text = dic[@"showTitle"];
    self.scoreLab.text = [NSString stringWithFormat:@"%@",dic[@"showScore"]];
    self.distanceLab.text = [NSString stringWithFormat:@"%@km",dic[@""]];
    self.addressLab.text = dic[@"showPlace"];
    self.detailLab.text = dic[@"showIntroduction"];
    if ([dic[@"showScore"] integerValue] < 2) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xingxing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"showScore"] integerValue] < 3){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"showScore"] integerValue] < 4){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"showScore"] integerValue] < 5){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"showScore"] integerValue] < 6){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xing"];
        self.fiveStar.image = [UIImage imageNamed:@"xing"];
    }
}


@end
