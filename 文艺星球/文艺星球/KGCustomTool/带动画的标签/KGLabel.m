//
//  KGLabel.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGLabel.h"

@interface KGLabel ()<CAAnimationDelegate>
/** 标签 */
@property (nonatomic,strong) UILabel *titleLab;
/** 是否点击 */
@property (nonatomic,assign) BOOL isSelect;

@end

@implementation KGLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 设置初始值为NO，没有点击 */
        self.isSelect = NO;
        [self setLabel];
    }
    return self;
}

/** 搭建界面 */
- (void)setLabel{
    self.titleLab = [[UILabel alloc]initWithFrame:self.bounds];
    self.titleLab.backgroundColor = [UIColor whiteColor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = [UIFont systemFontOfSize:13];
    self.titleLab.textColor = [UIColor grayColor];
    self.titleLab.layer.cornerRadius = self.bounds.size.height/2;
    self.titleLab.layer.borderWidth = 1;
    self.titleLab.layer.borderColor = [UIColor grayColor].CGColor;
    self.titleLab.layer.masksToBounds = YES;
    [self addSubview:self.titleLab];
}
/** 设置点击事件，修改状态 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isSelect == NO) {
        self.titleLab.backgroundColor = KGBlueColor;
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.layer.borderColor = KGBlueColor.CGColor;
        self.isSelect = YES;
    }else{
        self.titleLab.backgroundColor = [UIColor whiteColor];
        self.titleLab.textColor = [UIColor grayColor];
        self.titleLab.layer.borderColor = [UIColor grayColor].CGColor;
        self.isSelect = NO;
    }
}
/** 设置标题 */
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = title;
}
/** 标签id */
- (void)setLabID:(NSString *)labID{
    _labID = labID;
    self.titleLab.tag = [labID integerValue];
}
/** 移除动画 */
- (void)removeButton{
    CABasicAnimation * animaiton = [CABasicAnimation animationWithKeyPath:@"position"];
    animaiton.removedOnCompletion = NO;
    animaiton.fillMode = kCAFillModeForwards;
    animaiton.duration = 0.7;
    animaiton.toValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
    animaiton.delegate = self;
    [self.layer addAnimation:animaiton forKey:nil];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self removeFromSuperview];
}
/** 点击事件 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(sendTitle:labTag:)]) {
        [self.delegate sendTitle:self.title labTag:self.labID.integerValue];
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
