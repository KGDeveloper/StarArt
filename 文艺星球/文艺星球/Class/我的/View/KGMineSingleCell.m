//
//  KGMineSingleCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGMineSingleCell.h"

@interface KGMineSingleCell ()
/** 顶部左侧标签图 */
@property (nonatomic,strong) UIImageView *topleftImage;
/** 顶部标题 */
@property (nonatomic,strong) UILabel *toptitleLab;
/** 顶部右侧标签图 */
@property (nonatomic,strong) UIImageView *toprightImage;
/** 背景view */
@property (nonatomic,strong) UIView *backView;

@end

@implementation KGMineSingleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KGWhiteColor;
        [self setUI];
    }
    return self;
}
/** 搭建UI */
- (void)setUI{
    self.backView = [UIView new];
    [self.contentView sd_addSubviews:@[self.backView]];
    /** 设置背景view的阴影以及圆角 */
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shadowColor = KGBlueColor.CGColor;
    self.backView.layer.shadowOpacity = 0.8f;
    self.backView.layer.shadowOffset = CGSizeMake(0, 0);
    self.backView.layer.shadowRadius = 2;
    self.backView.backgroundColor = KGWhiteColor;
    self.backView.sd_layout.topSpaceToView(self.contentView, 5).leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).heightIs(50);
    /** 设置顶部view */
    self.topleftImage = [UIImageView new];
    self.toptitleLab = [UILabel new];
    self.toprightImage = [UIImageView new];
    [self.backView sd_addSubviews:@[self.topleftImage,self.toptitleLab,self.toprightImage]];
    /** 设置顶部左侧imageview */
    self.topleftImage.contentMode = UIViewContentModeScaleAspectFit;
    self.topleftImage.sd_layout.leftSpaceToView(self.backView, 10).centerYEqualToView(self.backView).widthIs(20).heightIs(20);
    /** 设置顶部label */
    self.toptitleLab.textColor = KGBlackColor;
    self.toptitleLab.font = KGFontSHRegular(14);
    /** 设置顶部右侧imageview */
    self.toptitleLab.sd_layout.leftSpaceToView(self.topleftImage, 10).centerYEqualToView(self.backView).widthIs(100).heightIs(20);
    self.toprightImage.contentMode = UIViewContentModeScaleAspectFit;
    self.toprightImage.sd_layout.rightSpaceToView(self.backView, 10).centerYEqualToView(self.backView).widthIs(10).heightIs(10);
}
/** 判断触摸点 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(selectViewWithTitile:)]) {
        [self.delegate selectViewWithTitile:self.infoDic[@"title"]];
    }
}
/** 赋值 */
- (void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    self.topleftImage.image = [UIImage imageNamed:infoDic[@"leftImage"]];
    self.toprightImage.image = [UIImage imageNamed:infoDic[@"rightImage"]];
    self.toptitleLab.text = infoDic[@"title"];
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
