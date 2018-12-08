//
//  KGExhibitionVCListViewCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGExhibitionVCListViewCell.h"

@implementation KGExhibitionVCListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 填充cell内容 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"exhibitionCover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.titleLab.text = dic[@"exhibitionTitle"];
    self.detailLab.text = dic[@"exhibitionAddres"];
}

@end
