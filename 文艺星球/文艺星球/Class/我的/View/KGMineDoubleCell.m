//
//  KGMineDoubleCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGMineDoubleCell.h"

@interface KGMineDoubleCell ()
/** 顶部左侧标签图 */
@property (nonatomic,strong) UIImageView *topleftImage;
/** 顶部标题 */
@property (nonatomic,strong) UILabel *toptitleLab;
/** 顶部右侧标签图 */
@property (nonatomic,strong) UIImageView *toprightImage;
/** 中间直线 */
@property (nonatomic,strong) UIView *line;
/** 顶部view */
@property (nonatomic,strong) UIView *topView;
/** 底部view */
@property (nonatomic,strong) UIView *lowView;
/** 背景view */
@property (nonatomic,strong) UIView *backView;
/** 底部左侧标签图 */
@property (nonatomic,strong) UIImageView *lowleftImage;
/** 底部标题 */
@property (nonatomic,strong) UILabel *lowtitleLab;
/** 底部右侧标签图 */
@property (nonatomic,strong) UIImageView *lowrightImage;

@end

@implementation KGMineDoubleCell

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
    self.backView.sd_layout.topSpaceToView(self.contentView, 5).leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).heightIs(100);
    /** 设置背景view的子view */
    self.topView = [UIView new];
    self.lowView = [UIView new];
    self.line = [UIView new];
    [self.backView sd_addSubviews:@[self.topView,self.lowView,self.line]];
    self.topView.sd_layout.leftSpaceToView(self.backView, 10).topSpaceToView(self.backView, 0).rightSpaceToView(self.backView, 10).heightIs(49);
    self.lowView.sd_layout.leftSpaceToView(self.backView, 10).bottomSpaceToView(self.backView, 0).rightSpaceToView(self.backView, 10).heightIs(49);
    self.line.backgroundColor = KGLineColor;
    self.line.sd_layout.leftSpaceToView(self.backView, 10).topSpaceToView(self.topView, 0).rightSpaceToView(self.backView, 10).heightIs(1);
    /** 设置顶部view */
    self.topleftImage = [UIImageView new];
    self.toptitleLab = [UILabel new];
    self.toprightImage = [UIImageView new];
    [self.topView sd_addSubviews:@[self.topleftImage,self.toptitleLab,self.toprightImage]];
    /** 设置顶部左侧imageview */
    self.topleftImage.contentMode = UIViewContentModeScaleAspectFit;
    self.topleftImage.sd_layout.leftSpaceToView(self.topView, 0).centerYEqualToView(self.topView).widthIs(20).heightIs(20);
    /** 设置顶部label */
    self.toptitleLab.textColor = KGBlackColor;
    self.toptitleLab.font = KGFontSHRegular(14);
    /** 设置顶部右侧imageview */
    self.toptitleLab.sd_layout.leftSpaceToView(self.topleftImage, 10).centerYEqualToView(self.topView).widthIs(100).heightIs(20);
    self.toprightImage.contentMode = UIViewContentModeScaleAspectFit;
    self.toprightImage.sd_layout.rightSpaceToView(self.topView, 0).centerYEqualToView(self.topView).widthIs(10).heightIs(10);
    /** 设置低部view */
    self.lowleftImage = [UIImageView new];
    self.lowtitleLab = [UILabel new];
    self.lowrightImage = [UIImageView new];
    [self.lowView sd_addSubviews:@[self.lowleftImage,self.lowtitleLab,self.lowrightImage]];
    /** 设置低部左侧imageview */
    self.lowleftImage.contentMode = UIViewContentModeScaleAspectFit;
    self.lowleftImage.sd_layout.leftSpaceToView(self.lowView, 0).centerYEqualToView(self.lowView).widthIs(20).heightIs(20);
    /** 设置低部label */
    self.lowtitleLab.textColor = KGBlackColor;
    self.lowtitleLab.font = KGFontSHRegular(14);
    /** 设置低部右侧imageview */
    self.lowtitleLab.sd_layout.leftSpaceToView(self.lowleftImage, 10).centerYEqualToView(self.lowView).widthIs(100).heightIs(20);
    self.lowrightImage.contentMode = UIViewContentModeScaleAspectFit;
    self.lowrightImage.sd_layout.rightSpaceToView(self.lowView, 0).centerYEqualToView(self.lowView).widthIs(10).heightIs(10);
}
/** 判断触摸点 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch.view == self.topView) {
        if ([self.delegate respondsToSelector:@selector(selectViewWithTitile:)]) {
            [self.delegate selectViewWithTitile:self.infoDic[@"toptitle"]];
        }
    }else if (touch.view == self.lowView){
        if ([self.delegate respondsToSelector:@selector(selectViewWithTitile:)]) {
            [self.delegate selectViewWithTitile:self.infoDic[@"lowtitle"]];
        }
    }
}
/** 赋值 */
- (void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    self.topleftImage.image = [UIImage imageNamed:infoDic[@"topleftImage"]];
    self.toprightImage.image = [UIImage imageNamed:infoDic[@"toprightImage"]];
    self.lowleftImage.image = [UIImage imageNamed:infoDic[@"lowleftImage"]];
    self.lowrightImage.image = [UIImage imageNamed:infoDic[@"lowrightImage"]];
    self.toptitleLab.text = infoDic[@"toptitle"];
    self.lowtitleLab.text = infoDic[@"lowtitle"];
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
