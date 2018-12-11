//
//  KGArtisticPeopleCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGArtisticPeopleCell.h"

@implementation KGArtisticPeopleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addFriends:(UIButton *)sender {
    
}

- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.customImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    self.nameLab.text = dic[@"userName"];
    [self.sexBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"age"]] forState:UIControlStateNormal];
    self.foucsLab.text = [NSString stringWithFormat:@"%@粉丝",dic[@"fan"]];
    self.professLab.text = dic[@"position"];
    [self.locationBtu setTitle:dic[@"hometown"] forState:UIControlStateNormal];
    if ([dic[@"sex"] integerValue] == 0) {
        [self.sexBtu setImage:[UIImage imageNamed:@"xingbienv"] forState:UIControlStateNormal];
        self.sexBtu.backgroundColor = KGWomanColor;
    }else{
        [self.sexBtu setImage:[UIImage imageNamed:@"xingbienan"] forState:UIControlStateNormal];
        self.sexBtu.backgroundColor = KGManColor;
    }
}


@end
