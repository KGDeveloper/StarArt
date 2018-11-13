//
//  KGDatingView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDatingView.h"

@interface KGDatingView ()
/** 背景图 */
@property (nonatomic,strong) UIImageView *backImageView;
/** 昵称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 年龄 */
@property (nonatomic,strong) UILabel *ageLab;
/** 职业 */
@property (nonatomic,strong) UILabel *professionalLab;
/** 匹配度 */
@property (nonatomic,strong) UIButton *compatibilityBtu;
/** 初始中心点 */
@property (nonatomic,assign) CGPoint originalPoint;
/** 初始坐标 */
@property (nonatomic,assign) CGRect originalFrame;
@property (nonatomic,strong) UIView *customView;

@end

@implementation KGDatingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /** 在移动范围不够时，返回初始状态 */
        self.originalFrame = frame;
        [self setUI];
    }
    return self;
}
/** 搭建UI */
- (void)setUI{
    
    self.customView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:self.customView];
    
    /** 添加滑动手势 */
    UISwipeGestureRecognizer *leftrecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [leftrecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.customView addGestureRecognizer:leftrecognizer];
    /** 添加滑动手势 */
    UISwipeGestureRecognizer *rightrecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [rightrecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.customView addGestureRecognizer:rightrecognizer];
    
    self.backImageView = [UIImageView new];
    self.nameLab = [UILabel new];
    self.ageLab = [UILabel new];
    self.professionalLab = [UILabel new];
    self.compatibilityBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customView sd_addSubviews:@[self.backImageView,self.nameLab,self.ageLab,self.professionalLab,self.compatibilityBtu]];
    /** 背景图 */
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.backgroundColor = KGRandomColor;
    self.backImageView.sd_layout
    .topEqualToView(self.customView)
    .leftEqualToView(self.customView)
    .rightEqualToView(self.customView)
    .bottomEqualToView(self.customView);
    /** 昵称 */
    self.nameLab.text = @"我是不是你最爱的人";
    self.nameLab.textColor = KGWhiteColor;
    self.nameLab.font = KGFontSHRegular(16);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.sd_layout
    .topSpaceToView(self.customView, self.customView.frame.size.height - 120)
    .leftSpaceToView(self.customView, 15)
    .rightSpaceToView(self.customView, 15)
    .heightIs(16);
    /** 职业 */
    self.professionalLab.text = @"教师";
    self.professionalLab.textColor = KGWhiteColor;
    self.professionalLab.font = KGFontSHRegular(13);
    self.professionalLab.sd_layout
    .topSpaceToView(self.nameLab, 15)
    .centerXEqualToView(self.nameLab)
    .widthIs(50)
    .heightIs(13);
    /** 年龄 */
    self.ageLab.text = @"24岁";
    self.ageLab.textColor = KGWhiteColor;
    self.ageLab.font = KGFontSHRegular(13);
    self.ageLab.textAlignment = NSTextAlignmentRight;
    self.ageLab.sd_layout
    .rightSpaceToView(self.professionalLab, 10)
    .topSpaceToView(self.nameLab, 15)
    .leftSpaceToView(self.customView, 15)
    .heightIs(13);
    /** 匹配度 */
    [self.compatibilityBtu setTitle:@"85%匹配" forState:UIControlStateNormal];
    [self.compatibilityBtu setImage:[UIImage imageNamed:@"xingbienv"] forState:UIControlStateNormal];
    self.compatibilityBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.compatibilityBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.compatibilityBtu.userInteractionEnabled = NO;
    self.compatibilityBtu.titleLabel.font = KGFontSHRegular(10);
    self.compatibilityBtu.backgroundColor = KGWomanColor;
    self.compatibilityBtu.layer.cornerRadius = 7.5;
    self.compatibilityBtu.layer.masksToBounds = YES;
    self.compatibilityBtu.sd_layout
    .topSpaceToView(self.nameLab, 15)
    .leftSpaceToView(self.professionalLab, 0)
    .widthIs(70)
    .heightIs(15);
    
}
/** 滑动事件 */
- (void)pan:(UISwipeGestureRecognizer *)pan{
    /** 右滑 */
    if (pan.direction == UISwipeGestureRecognizerDirectionRight) {
        /** 向控制器发送通知，跳转聊天页面 */
        if (self.rightMoveStarChat) {
            self.rightMoveStarChat(@"开始聊天");
        }
        [self removeFromSuperview];
    }
    /** 左滑 */
    if (pan.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(-KGScreenWidth, KGScreenHeight/4, KGScreenWidth/2, KGScreenHeight/2);
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        /** 向控制器发送通知，加载下一个数据 */
        if (self.leftMoveRemoveSelf) {
            self.leftMoveRemoveSelf();
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
