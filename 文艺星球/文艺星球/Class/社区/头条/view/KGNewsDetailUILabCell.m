//
//  KGNewsDetailUILabCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNewsDetailUILabCell.h"

@interface KGNewsDetailUILabCell ()
/** 详情 */
@property (nonatomic,strong) UILabel *detailLab;

@end

@implementation KGNewsDetailUILabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}
/** 搭建界面 */
- (void)setCell{
    self.detailLab = [UILabel new];
    
    [self.contentView addSubview:self.detailLab];
    
    
    self.detailLab.textColor = KGBlackColor;
    self.detailLab.font = KGFontSHRegular(13);
    self.detailLab.numberOfLines = 0;
    self.detailLab.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(200);
    
}

- (void)cellDetailWithString:(NSString *)str{
    
    self.detailLab.text = str;
    
    self.detailLab.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs([str boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(13)} context:nil].size.height);
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
