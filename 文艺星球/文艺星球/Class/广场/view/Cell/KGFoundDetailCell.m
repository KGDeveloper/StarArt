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
@property (nonatomic,copy) NSDictionary *dataDic;

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
    .widthIs(80)
    .heightEqualToWidth();
    self.twoImage.contentMode = UIViewContentModeScaleAspectFill;
    self.twoImage.backgroundColor = KGLineColor;
    self.twoImage.sd_layout
    .topSpaceToView(self.detailLab, 10)
    .leftSpaceToView(self.oneImage, 5)
    .widthIs(80)
    .heightEqualToWidth();
    self.threeImage.contentMode = UIViewContentModeScaleAspectFill;
    self.threeImage.backgroundColor = KGLineColor;
    self.threeImage.sd_layout
    .topSpaceToView(self.detailLab, 10)
    .leftSpaceToView(self.twoImage, 5)
    .widthIs(80)
    .heightEqualToWidth();
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
    
}
/** 点赞 */
- (void)zansAction:(UIButton *)sender{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequest postWithUrl:SaveUserGoodPlaceCommentLikeStuts parameters:@{@"cid":self.dataDic[@"id"],@"uid":[KGUserInfo shareInstance].userId,@"likeStatus":self.dataDic[@"likeStatus"]} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
                [[KGHUD showMessage:@"取消点赞成功"] hideAnimated:YES afterDelay:1];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
                [[KGHUD showMessage:@"点赞成功"] hideAnimated:YES afterDelay:1];
            }
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
}
/** 计算高度 */
- (CGFloat)returnCellHeightWithDic:(NSDictionary *)dic{
    NSMutableArray *ImageArr = [NSMutableArray array];
    if (![dic[@"images"] isKindOfClass:[NSNull class]]) {
        NSArray *tmp = dic[@"images"];
        if (tmp.count > 0) {
            [ImageArr addObjectsFromArray:tmp];
        }
    }
    
    if (ImageArr.count > 0) {
        return 200 + [dic[@"comment"] boundingRectWithSize:CGSizeMake(KGScreenWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(12)} context:nil].size.height;
    }else{
        return 100 + [dic[@"comment"] boundingRectWithSize:CGSizeMake(KGScreenWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(12)} context:nil].size.height;
    }
}
/** 填充 */
- (void)cellWithDic:(NSDictionary *)dic{
    self.dataDic = dic;
    NSDictionary *userDic = dic[@"user"];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:userDic[@"portraitUri"]]];
    self.nameLab.text = userDic[@"username"];
    self.detailLab.text = dic[@"comment"];
    self.detailLab.sd_layout
    .leftEqualToView(self.nameLab)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.headerImage, 15)
    .autoHeightRatio(0);
    NSMutableArray *ImageArr = [NSMutableArray array];
    if (![dic[@"images"] isKindOfClass:[NSNull class]]) {
        NSArray *tmp = dic[@"images"];
        if (tmp.count > 0) {
            [ImageArr addObjectsFromArray:tmp];
        }
    }
    if (ImageArr.count > 0) {
        if (ImageArr.count == 1) {
            self.oneImage.hidden = NO;
            [self.oneImage sd_setImageWithURL:[NSURL URLWithString:[ImageArr firstObject]]];
            self.twoImage.hidden = YES;
            self.threeImage.hidden = YES;
        }else if (ImageArr.count == 2){
            self.oneImage.hidden = NO;
            self.twoImage.hidden = NO;
            [self.oneImage sd_setImageWithURL:[NSURL URLWithString:[ImageArr firstObject]]];
            [self.twoImage sd_setImageWithURL:[NSURL URLWithString:[ImageArr lastObject]]];
            self.threeImage.hidden = YES;
        }else{
            self.oneImage.hidden = NO;
            self.twoImage.hidden = NO;
            self.threeImage.hidden = NO;
            [self.oneImage sd_setImageWithURL:[NSURL URLWithString:[ImageArr firstObject]]];
            [self.twoImage sd_setImageWithURL:[NSURL URLWithString:ImageArr[1]]];
            [self.threeImage sd_setImageWithURL:[NSURL URLWithString:[ImageArr lastObject]]];
        }
        self.zansBtu.sd_layout
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.oneImage, 15)
        .widthIs(100)
        .heightIs(15);
        self.line.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.timeLab, 15)
        .heightIs(1);
    }else{
        self.oneImage.hidden = YES;
        self.twoImage.hidden = YES;
        self.threeImage.hidden = YES;
        self.zansBtu.sd_layout
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.detailLab, 15)
        .widthIs(100)
        .heightIs(15);
        self.line.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.timeLab, 15)
        .heightIs(1);
    }
    self.timeLab.text = dic[@"createTimeStr"];
    self.timeLab.sd_layout
    .leftEqualToView(self.detailLab)
    .topSpaceToView(self.oneImage, 15)
    .widthIs(150)
    .heightIs(10);
    if ([dic[@"likeStatus"] integerValue] == 0) {
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }else{
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }
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
