//
//  KGInstitutionMoviesDetailCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionMoviesDetailCell.h"

@implementation KGInstitutionMoviesDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 填充内容 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.cusImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"cover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.nameLab.text = dic[@"title"];
    if (![dic[@"movieType"] isKindOfClass:[NSNull class]]) {
        self.classLab.text = dic[@"movieType"];
    }else{
        self.classLab.text = @"暂无分类";
    }
    if (![dic[@"movieNationality"] isKindOfClass:[NSNull class]]) {
        if (![dic[@"openDate"] isKindOfClass:[NSNull class]]) {
            self.locationLab.text = [NSString stringWithFormat:@"%@/%@",dic[@"movieNationality"],dic[@"openDate"]];
        }else{
            self.locationLab.text = [NSString stringWithFormat:@"%@",dic[@"movieNationality"]];
        }
    }else{
        self.locationLab.text = @"";
    }
    if (![dic[@"openDate"] isKindOfClass:[NSNull class]]) {
        self.locationLab.text = [NSString stringWithFormat:@"%@",dic[@"openDate"]];
    }
}

@end
