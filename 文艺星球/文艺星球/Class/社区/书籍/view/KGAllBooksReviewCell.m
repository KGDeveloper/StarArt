//
//  KGAllBooksReviewCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAllBooksReviewCell.h"

@interface KGAllBooksReviewCell ()
/** 头像 */
@property (nonatomic,strong) UIImageView *headerImage;
/** 昵称 */
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIImageView *oneStar;
@property (nonatomic,strong) UIImageView *twoStar;
@property (nonatomic,strong) UIImageView *threeStar;
@property (nonatomic,strong) UIImageView *fourStar;
@property (nonatomic,strong) UIImageView *fiveStar;
/** 点赞 */
@property (nonatomic,strong) UIButton *zansBtu;
/** 详情 */
@property (nonatomic,strong) UILabel *detailLab;
/** 发布时间 */
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UIView *line;

@end

@implementation KGAllBooksReviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}
/** 搭建cell */
- (void)setCell{
    self.headerImage = [UIImageView new];
    self.oneStar = [UIImageView new];
    self.twoStar = [UIImageView new];
    self.threeStar = [UIImageView new];
    self.fourStar = [UIImageView new];
    self.fiveStar = [UIImageView new];
    self.nameLab = [UILabel new];
    self.detailLab = [UILabel new];
    self.timeLab = [UILabel new];
    self.zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.line = [UIView new];
    
    [self.contentView sd_addSubviews:@[self.headerImage,self.oneStar,self.twoStar,self.threeStar,self.fourStar,self.fiveStar,self.nameLab,self.detailLab,self.timeLab,self.zansBtu,self.line]];
    
    /** 头像 */
    self.headerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImage.backgroundColor = KGLineColor;
    self.headerImage.layer.cornerRadius = 10;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(20)
    .heightIs(20);
    /** 昵称 */
    self.nameLab.text = @"遥不可及";
    self.nameLab.textColor = KGGrayColor;
    self.nameLab.font = KGFontSHRegular(12);
    self.nameLab.sd_layout
    .leftSpaceToView(self.headerImage, 10)
    .centerYEqualToView(self.headerImage)
    .widthIs(100)
    .heightIs(12);
    /** 星星 */
    self.oneStar.image = [UIImage imageNamed:@"xing"];
    self.oneStar.sd_layout
    .leftSpaceToView(self.nameLab, 30)
    .centerYEqualToView(self.nameLab)
    .widthIs(12)
    .heightIs(12);
    self.twoStar.image = [UIImage imageNamed:@"xing"];
    self.twoStar.sd_layout
    .leftSpaceToView(self.oneStar, 5)
    .centerYEqualToView(self.oneStar)
    .widthIs(12)
    .heightIs(12);
    self.threeStar.image = [UIImage imageNamed:@"xing"];
    self.threeStar.sd_layout
    .leftSpaceToView(self.twoStar, 5)
    .centerYEqualToView(self.twoStar)
    .widthIs(12)
    .heightIs(12);
    self.fourStar.image = [UIImage imageNamed:@"xing"];
    self.fourStar.sd_layout
    .leftSpaceToView(self.threeStar, 5)
    .centerYEqualToView(self.threeStar)
    .widthIs(12)
    .heightIs(12);
    self.fiveStar.image = [UIImage imageNamed:@"xing"];
    self.fiveStar.sd_layout
    .leftSpaceToView(self.fourStar, 5)
    .centerYEqualToView(self.fourStar)
    .widthIs(12)
    .heightIs(12);
    /** 点赞 */
    [self.zansBtu setTitle:@"34" forState:UIControlStateNormal];
    [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    self.zansBtu.titleLabel.font = KGFontSHRegular(9);
    self.zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.zansBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    self.zansBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    self.zansBtu.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.headerImage)
    .widthIs(100)
    .heightIs(17);
    /** 详情 */
    self.detailLab.text = @"安达市大所大所大多撒多";
    self.detailLab.textColor = KGBlackColor;
    self.detailLab.font = KGFontSHRegular(13);
    self.detailLab.numberOfLines = 0;
    self.detailLab.sd_layout
    .leftEqualToView(self.nameLab)
    .rightEqualToView(self.zansBtu)
    .topSpaceToView(self.headerImage, 15)
    .heightIs(20);
    /** 时间 */
    self.timeLab.text = @"6分钟前";
    self.timeLab.textColor = KGGrayColor;
    self.timeLab.font = KGFontSHRegular(10);
    self.timeLab.sd_layout
    .leftEqualToView(self.detailLab)
    .topSpaceToView(self.detailLab, 11)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(10);
    /** 直线 */
    self.line.backgroundColor = KGLineColor;
    self.line.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.timeLab, 15)
    .heightIs(10);
    
}
- (CGFloat)cellHeightWithDictionary:(NSDictionary *)dic{
    return [dic[@"comment"] boundingRectWithSize:CGSizeMake(KGScreenWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(13)} context:nil].size.height + 100;
}
/** 点赞 */
- (void)zansAction:(UIButton *)sender{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequest postWithUrl:AddCommentLikeStatusByCid parameters:@{@"cid":@(sender.tag)} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"操作成功"] hideAnimated:YES afterDelay:1];
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
}
- (void)cellDetailWithDictionary:(NSDictionary *)dic{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"portraituri"] componentsSeparatedByString:@"#"] firstObject]]];
    self.nameLab.text = dic[@"username"];
    self.nameLab.sd_layout
    .leftSpaceToView(self.headerImage, 10)
    .centerYEqualToView(self.headerImage)
    .widthIs([dic[@"username"] boundingRectWithSize:CGSizeMake(KGScreenWidth/2,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(12)} context:nil].size.width)
    .heightIs(12);
    if ([dic[@"score"] integerValue] < 2) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xingxing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"score"] integerValue] < 3) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"score"] integerValue] < 4) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"score"] integerValue] < 5) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"score"] integerValue] < 6) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xing"];
        self.fiveStar.image = [UIImage imageNamed:@"xing"];
    }
    self.oneStar.sd_layout
    .leftSpaceToView(self.nameLab, 30)
    .centerYEqualToView(self.nameLab)
    .widthIs(12)
    .heightIs(12);
    self.twoStar.sd_layout
    .leftSpaceToView(self.oneStar, 5)
    .centerYEqualToView(self.oneStar)
    .widthIs(12)
    .heightIs(12);
    self.threeStar.sd_layout
    .leftSpaceToView(self.twoStar, 5)
    .centerYEqualToView(self.twoStar)
    .widthIs(12)
    .heightIs(12);
    self.fourStar.sd_layout
    .leftSpaceToView(self.threeStar, 5)
    .centerYEqualToView(self.threeStar)
    .widthIs(12)
    .heightIs(12);
    self.fiveStar.sd_layout
    .leftSpaceToView(self.fourStar, 5)
    .centerYEqualToView(self.fourStar)
    .widthIs(12)
    .heightIs(12);
    if ([dic[@"likeStatus"] integerValue] == 0) {
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }else{
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }
    [self.zansBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"goodSum"]] forState:UIControlStateNormal];
    self.zansBtu.tag = [dic[@"id"] integerValue];
    self.detailLab.text = dic[@"comment"];
    self.detailLab.sd_layout
    .leftEqualToView(self.nameLab)
    .rightEqualToView(self.zansBtu)
    .topSpaceToView(self.headerImage, 15)
    .heightIs([dic[@"comment"] boundingRectWithSize:CGSizeMake(KGScreenWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(13)} context:nil].size.height);
    self.timeLab.text = dic[@"commentTime"];
    self.timeLab.sd_layout
    .leftEqualToView(self.detailLab)
    .topSpaceToView(self.detailLab, 11)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(10);
    self.line.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.timeLab, 15)
    .heightIs(10);
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
