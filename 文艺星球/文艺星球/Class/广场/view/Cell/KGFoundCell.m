//
//  KGFoundCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFoundCell.h"

@implementation KGFoundCell

/** 数据填充 */
- (void)sendModelToCell:(NSDictionary *)dic{
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]]];
    NSArray *tmpImageArr = dic[@"images"];
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:tmpImageArr[0]]];
    [self.centerImage sd_setImageWithURL:[NSURL URLWithString:tmpImageArr[1]]];
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:tmpImageArr[2]]];
    self.nameLab.text = dic[@"placenameca"];
    self.englishLab.text = dic[@"placenameeh"];
    self.classLab.text = dic[@"typeName"];
    if ([dic[@"graded"] integerValue] < 2) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xingxing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"graded"] integerValue] < 3){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"graded"] integerValue] < 4){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"graded"] integerValue] < 5){
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
