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
    
    [self.contentView sd_addSubviews:@[self.headerImage,self.nameLab,self.starView,self.detailLab,self.timeLab,self.zansBtu,self.line]];
    self.contentView.sd_equalWidthSubviews = @[self.oneImage,self.twoImage,self.threeImage];
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
