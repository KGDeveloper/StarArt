
//
//  KGNewsDetailUIImageViewCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNewsDetailUIImageViewCell.h"

@interface KGNewsDetailUIImageViewCell ()
/** 详情 */
@property (nonatomic,strong) UIImageView *customImage;

@end

@implementation KGNewsDetailUIImageViewCell

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
    self.customImage = [UIImageView new];
    
    [self.contentView addSubview:self.customImage];
    
    self.customImage.backgroundColor = KGLineColor;
    self.customImage.contentMode = UIViewContentModeScaleAspectFill;
    self.customImage.layer.cornerRadius = 5;
    self.customImage.layer.masksToBounds = YES;
    self.customImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(200);
    
    [self.contentView setupAutoHeightWithBottomView:self.customImage bottomMargin:30];
    
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
