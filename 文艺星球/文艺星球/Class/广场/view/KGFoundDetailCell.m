//
//  KGFoundDetailCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFoundDetailCell.h"

@interface KGFoundDetailCell ()
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIView *starView;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UIImageView *oneImage;
@property (nonatomic,strong) UIImageView *twoImage;
@property (nonatomic,strong) UIImageView *threeImage;
@property (nonatomic,strong) UIButton *zansBtu;
@property (nonatomic,strong) UIView *line;

@end

@implementation KGFoundDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.headerImage = [UIImageView new];
    self.nameLab = [UILabel new];
    self.starView = [UIView new];
    self.detailLab = [UILabel new];
    self.timeLab = [UILabel new];
    self.oneImage = [UIImageView new];
    self.twoImage = [UIImageView new];
    self.threeImage = [UIImageView new];
    self.zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.line = [UIView new];
    
    [self.contentView sd_addSubviews:@[self.headerImage,self.nameLab,self.starView,self.detailLab,self.oneImage,self.twoImage,self.threeImage,self.timeLab,self.zansBtu,self.line]];
    self.contentView.sd_equalWidthSubviews = @[self.oneImage,self.twoImage,self.threeImage];
    
    /** 头像 */
    self.headerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImage.layer.cornerRadius = 10;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.backgroundColor = KGLineColor;
    self.headerImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .widthIs(20)
    .heightIs(20);
    /** 昵称 */
    self.nameLab.textColor = KGGrayColor;
    self.nameLab.font = KGFontSHRegular(13);
    self.nameLab.text = @"哈哈哈哈";
    self.nameLab.sd_layout
    .leftSpaceToView(self.headerImage, 10)
    .centerYEqualToView(self.headerImage)
    .widthIs(150)
    .heightIs(13);
    /** 星星view */
    self.starView.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.headerImage)
    .widthIs(85)
    .heightIs(12);
    /** 内容 */
    self.detailLab.text = @"那是大事看的老娘都看见对方那个空间发你看你空间的那点事";
    self.detailLab.textColor = KGBlackColor;
    self.detailLab.font = KGFontSHRegular(12);
    self.detailLab.numberOfLines = 0;
    self.detailLab.sd_layout
    .leftEqualToView(self.nameLab)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.headerImage, 15)
    .autoHeightRatio(0);
    /** 图片 */
    self.oneImage.contentMode = UIViewContentModeScaleAspectFill;
    self.oneImage.backgroundColor = KGLineColor;
    self.oneImage.sd_layout
    .topSpaceToView(self.detailLab, 10)
    .leftEqualToView(self.detailLab)
    .autoHeightRatio(1);
    self.twoImage.contentMode = UIViewContentModeScaleAspectFill;
    self.twoImage.backgroundColor = KGLineColor;
    self.twoImage.sd_layout
    .topSpaceToView(self.detailLab, 10)
    .leftSpaceToView(self.oneImage, 5)
    .autoHeightRatio(1);
    self.threeImage.contentMode = UIViewContentModeScaleAspectFill;
    self.threeImage.backgroundColor = KGLineColor;
    self.threeImage.sd_layout
    .topSpaceToView(self.detailLab, 10)
    .rightEqualToView(self.detailLab)
    .leftSpaceToView(self.twoImage, 5)
    .autoHeightRatio(1);
    /** 时间 */
    self.timeLab.text = @"5 小时前";
    self.timeLab.textColor = KGGrayColor;
    self.timeLab.font = KGFontSHRegular(10);
    self.timeLab.sd_layout
    .leftEqualToView(self.detailLab)
    .topSpaceToView(self.oneImage, 15)
    .widthIs(150)
    .heightIs(10);
    /** 点赞按钮 */
    [self.zansBtu setTitle:@"321" forState:UIControlStateNormal];
    [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    self.zansBtu.titleLabel.font = KGFontSHRegular(12);
    self.zansBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    self.zansBtu.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.oneImage, 15)
    .widthIs(100)
    .heightIs(15);
    /** 分割线 */
    self.line.backgroundColor = KGLineColor;
    self.line.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.timeLab, 15)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:self.line bottomMargin:0];
}
/** 点赞 */
- (void)zansAction:(UIButton *)sender{
    
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
