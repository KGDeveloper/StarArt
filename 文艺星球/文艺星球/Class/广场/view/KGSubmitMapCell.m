//
//  KGSubmitMapCell.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSubmitMapCell.h"

@interface KGSubmitMapCell ()

@property (nonatomic,strong) UIImageView *mapImage;

@end

@implementation KGSubmitMapCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}
- (void)setUI{
    self.mapImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, KGScreenWidth - 30, (KGScreenWidth - 30)/690*260)];
    self.mapImage.contentMode = UIViewContentModeScaleAspectFill;
    self.mapImage.backgroundColor = KGLineColor;
    self.mapImage.image = [UIImage imageNamed:@"好去处实例地图"];
    self.mapImage.layer.cornerRadius = 5;
    self.mapImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.mapImage];
    
    UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(15, (KGScreenWidth - 30)/690*260 + 20, KGScreenWidth - 30, 50)];
    addressLab.text = @"详细地址";
    addressLab.textColor = KGBlackColor;
    addressLab.font = KGFontSHRegular(14);
    [self.contentView addSubview:addressLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, (KGScreenWidth - 30)/690*260 + 69, KGScreenWidth - 30, 1)];
    line.backgroundColor = KGLineColor;
    [self.contentView addSubview:line];
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
