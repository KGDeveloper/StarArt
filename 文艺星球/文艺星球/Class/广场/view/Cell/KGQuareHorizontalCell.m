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
/** 底部线 */
@property (nonatomic,strong) UIView *line;
@property (nonatomic,assign) NSTextAlignment alignment;
@property (nonatomic,copy) NSDictionary *userDic;

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
    self.line = [UIView new];
    
    [self.contentView sd_addSubviews:@[self.headerImage,self.nameLab,self.timeLab,self.labView,self.photoView,self.locationBtu,self.markImage,self.zansBtu,self.commentsBtu,self.countBack,self.countLab,self.line]];
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
    self.labView.sd_layout.leftEqualToView(self.headerImage).topSpaceToView(self.headerImage, 15).rightSpaceToView(self.contentView, 15).heightIs(115);
    /** 图片view */
    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoView.backgroundColor = KGLineColor;
    self.photoView.layer.masksToBounds = YES;
    self.photoView.sd_layout.leftEqualToView(self.labView).rightEqualToView(self.labView).topSpaceToView(self.labView, 15).heightIs((KGScreenWidth - 30)/69*46);
    /** 显示照片书view */
    self.countBack.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
    self.countBack.sd_layout.rightSpaceToView(self.contentView, 15).bottomEqualToView(self.photoView).widthIs(30).heightIs(15);
    /** 数目 */
    self.countLab.text = @"1/9";
    self.countLab.textColor = KGWhiteColor;
    self.countLab.font = KGFontSHRegular(14);
    self.countLab.textAlignment = NSTextAlignmentCenter;
    self.countLab.sd_layout.rightEqualToView(self.countBack).bottomEqualToView(self.countBack).widthIs(30).heightIs(15);
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
    /** 评论 */
    [self.commentsBtu setTitle:@"232" forState:UIControlStateNormal];
    [self.commentsBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.commentsBtu setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    self.commentsBtu.titleLabel.font = KGFontSHRegular(13);
    self.commentsBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.commentsBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.commentsBtu.userInteractionEnabled = NO;
    self.commentsBtu.sd_layout.rightSpaceToView(self.contentView, 15).topSpaceToView(self.locationBtu, 15).widthIs(50).heightIs(15);
    /** 点赞 */
    [self.zansBtu setTitle:@"232" forState:UIControlStateNormal];
    [self.zansBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    self.zansBtu.titleLabel.font = KGFontSHRegular(13);
    self.zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.zansBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    self.zansBtu.sd_layout.rightSpaceToView(self.commentsBtu, 15).topSpaceToView(self.locationBtu, 15).widthIs(50).heightIs(15);
    /** 底部直线 */
    self.line.backgroundColor = KGLineColor;
    self.line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
}
/** 点赞 */
- (void)zansAction:(UIButton *)sender{
    NSArray *tmp = self.userDic[@"imgs"];
    NSDictionary *tmpDic = [tmp firstObject];
    [KGRequest postWithUrl:[addLike stringByAppendingString:[NSString stringWithFormat:@"/%@",self.userDic[@"id"]]] parameters:@{@"portraitUri":[KGUserInfo shareInstance].userPortrait,@"rfmImg":tmpDic[@"imageUrl"],@"comName":[KGUserInfo shareInstance].userName} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }
            [[KGHUD showMessage:@"操作成功"] hideAnimated:YES afterDelay:1];
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
}
/** 获取cell高度 */
- (CGFloat)rowHeightWithDictionary:(NSDictionary *)dic{
    NSString *contentStr = dic[@"content"];
    NSArray *endArr = [contentStr componentsSeparatedByString:@"@"];
    return 140+endArr.count*23+(KGScreenWidth - 30)/69*46;
}
/** 创建label */
- (void)setLabelWithArr:(NSArray *)arr{
    if (arr.count > 0) {
        for (int i = 0; i < arr.count; i++) {
            UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(0,23*i, KGScreenWidth - 30, 13)];
            tmp.text = arr[i];
            tmp.textColor = KGBlackColor;
            tmp.font = KGFontFZ(13);
            tmp.textAlignment = self.alignment;
            [self.labView addSubview:tmp];
        }
        self.labView.sd_layout.leftEqualToView(self.headerImage).topSpaceToView(self.headerImage, 15).rightSpaceToView(self.contentView, 15).heightIs(arr.count*23 - 10);
        self.photoView.sd_layout.leftEqualToView(self.labView).rightEqualToView(self.labView).topSpaceToView(self.labView, 15).heightIs((KGScreenWidth - 30)/69*46);
        self.countBack.sd_layout.rightSpaceToView(self.contentView, 15).bottomEqualToView(self.photoView).widthIs(30).heightIs(15);
        self.countLab.sd_layout.rightEqualToView(self.countBack).bottomEqualToView(self.countBack).widthIs(30).heightIs(15);
        self.locationBtu.sd_layout.leftEqualToView(self.photoView).topSpaceToView(self.photoView, 15).rightEqualToView(self.photoView).heightIs(11);
        self.markImage.sd_layout.leftEqualToView(self.locationBtu).topSpaceToView(self.locationBtu, 15).widthIs(11).heightIs(14);
        self.commentsBtu.sd_layout.rightSpaceToView(self.contentView, 15).topSpaceToView(self.locationBtu, 15).widthIs(50).heightIs(15);
        self.zansBtu.sd_layout.rightSpaceToView(self.commentsBtu, 15).topSpaceToView(self.locationBtu, 15).widthIs(50).heightIs(15);
        self.line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    }
}
/** 设置内容 */
- (void)cellDataWithDictionary:(NSDictionary *)dic{
    NSString *contentStr = dic[@"content"];
    [self.labView removeAllSubviews];
    self.userDic = dic;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"userPortraitUri"]]];
    self.nameLab.text = dic[@"userName"];
    self.timeLab.text = dic[@"createTimeStr"];
    [self.locationBtu setTitle:dic[@"location"] forState:UIControlStateNormal];
    NSArray *imageTmpArr = dic[@"imgs"];
    self.countLab.text = [NSString stringWithFormat:@"1/%ld",(long)imageTmpArr.count];
    NSDictionary *imageDic = [imageTmpArr firstObject];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
    if ([dic[@"isLike"] integerValue] == 0) {
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }else{
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }
    [self.commentsBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"rccommentNum"]] forState:UIControlStateNormal];
    [self.zansBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"likeCount"]] forState:UIControlStateNormal];
    if ([dic[@"composing"] integerValue] == 0) {
        self.alignment = NSTextAlignmentLeft;
    }else{
        self.alignment = NSTextAlignmentCenter;
    }
    NSArray *endArr = [contentStr componentsSeparatedByString:@"@"];
    [self setLabelWithArr:endArr];
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
