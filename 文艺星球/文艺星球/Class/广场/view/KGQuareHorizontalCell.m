//
//  KGQuareHorizontalCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGQuareHorizontalCell.h"

@interface KGQuareHorizontalCell ()
/** 头像 */
@property (nonatomic,strong) UIImageView *headerImage;
/** 昵称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 文本 */
@property (nonatomic,strong) UIView *labView;
/** 图片 */
@property (nonatomic,strong) UIImageView *photoView;
/** 位置 */
@property (nonatomic,strong) UIButton *locationBtu;
/** 标记 */
@property (nonatomic,strong) UIImageView *markImage;
/** 点赞 */
@property (nonatomic,strong) UIButton *zansBtu;
/** 评论 */
@property (nonatomic,strong) UIButton *commentsBtu;
/** 图片数量 */
@property (nonatomic,strong) UIView *countBack;
/** 图片数目 */
@property (nonatomic,strong) UILabel *countLab;

@end

@implementation KGQuareHorizontalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpHeader];
    }
    return self;
}
/** 头像 */
- (void)setUpHeader{
    self.headerImage = [UIImageView new];
    self.nameLab = [UILabel new];
    self.timeLab = [UILabel new];
    self.labView = [UIView new];
    self.photoView = [UIImageView new];
    self.locationBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.markImage = [UIImageView new];
    self.zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentsBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countBack = [UIView new];
    self.countLab = [UILabel new];
    
    [self.contentView sd_addSubviews:@[self.headerImage,self.nameLab,self.timeLab,self.labView,self.photoView,self.locationBtu,self.markImage,self.zansBtu,self.commentsBtu,self.countBack,self.countLab]];
    /** 头像 */
    self.headerImage.layer.cornerRadius = 17.5;
    self.headerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.backgroundColor = KGLineColor;
    self.headerImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 10).widthIs(35).heightIs(35);
    /** 昵称 */
    self.nameLab.text = @"巴啦啦能量";
    self.nameLab.textColor = KGBlueColor;
    self.nameLab.font = KGFontSHRegular(14);
    self.nameLab.sd_layout.leftSpaceToView(self.headerImage, 10).topEqualToView(self.headerImage).rightSpaceToView(self.contentView, 15).heightIs(14);
    /** 时间 */
    self.timeLab.text = @"3分钟前";
    self.timeLab.textColor = KGGrayColor;
    self.timeLab.font = KGFontSHRegular(12);
    self.timeLab.sd_layout.leftSpaceToView(self.headerImage, 10).bottomEqualToView(self.headerImage).rightSpaceToView(self.contentView, 15).heightIs(12);
    /** labelview */
    self.labView.sd_layout.leftEqualToView(self.headerImage).topSpaceToView(self.headerImage, 15).rightSpaceToView(self.contentView, 15).heightIs(110);
    /** 图片view */
    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoView.backgroundColor = KGLineColor;
    self.photoView.sd_layout.leftEqualToView(self.labView).rightEqualToView(self.labView).topSpaceToView(self.labView, 15).heightIs((KGScreenWidth - 30)/69*46);
    /** 位置 */
    [self.locationBtu setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [self.locationBtu setTitle:@"北京798艺术区" forState:UIControlStateNormal];
    [self.locationBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.locationBtu.titleLabel.font = KGFontSHRegular(11);
    self.locationBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.locationBtu.userInteractionEnabled = NO;
    self.locationBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.locationBtu.sd_layout.leftEqualToView(self.photoView).topSpaceToView(self.photoView, 15).rightEqualToView(self.photoView).heightIs(11);
    /** 收藏标记 */
    self.markImage.image = [UIImage imageNamed:@"shoucang (2)"];
    self.markImage.contentMode = UIViewContentModeScaleAspectFit;
    self.markImage.sd_layout.leftEqualToView(self.locationBtu).topSpaceToView(self.locationBtu, 15).widthIs(11).heightIs(14);
    
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
