//
//  KGAgencyDetailListViewCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyDetailListViewCell.h"

@implementation KGAgencyDetailListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"cover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.nameLab.text = dic[@"title"];
    self.timeLab.text = dic[@"openDate"];
}

@end
