//
//  KGPerformanceCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGPerformanceCell.h"

@implementation KGPerformanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"showCover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.nameLab.text = dic[@"showTitle"];
    self.timeLab.text = dic[@"showTime"];
    self.locationLab.text = dic[@"showPlace"];
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",dic[@"showPrice"]];
}


@end
