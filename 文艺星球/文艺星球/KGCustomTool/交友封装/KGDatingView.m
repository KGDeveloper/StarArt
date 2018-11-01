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
@property (nonatomic,strong) UILabel *compatibilityLab;
/** 初始中心点 */
@property (nonatomic,assign) CGPoint originalPoint;
/** 初始坐标 */
@property (nonatomic,assign) CGRect originalFrame;

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
    /** 添加背景图 */
    self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.backImageView];
    /** 添加昵称标签 */
    
    /** 添加滑动手势 */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
}
/** 滑动事件 */
- (void)pan:(UIPanGestureRecognizer *)pan{
    /** 当移动手势开始时，记录当前触控点对于控制器的位置坐标并且记录 */
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.originalPoint = [self convertPoint:[pan locationInView:pan.view] toView:self.superview];
    }else if (pan.state == UIGestureRecognizerStateEnded){
        /** 当移动手势结束，计算当前触控点对于控制器的位置坐标并且记录 */
        CGPoint point = [self convertPoint:[pan locationInView:pan.view] toView:self.superview];
        /** 滑动距离计算，正值代表向右滑动，负值代表向左滑动 */
        NSNumber *currPoint = [NSNumber numberWithFloat:self.originalPoint.x - point.x];
        NSNumber *leftX = [NSNumber numberWithFloat:-150.0f];
        NSNumber *rightX = [NSNumber numberWithFloat:150.0f];
        /** 如果滑动值小于-150，说明是向右滑动，那么开始聊天 */
        if ([currPoint compare:leftX] == kCFCompareLessThan) {
            /** 向控制器发送通知，跳转聊天页面 */
            if (self.rightMoveStarChat) {
                self.rightMoveStarChat(@"开始聊天");
            }
            /** 如果滑动距离大于150，说明是向左滑动，那么从控制器移除 */
        }else if ([currPoint compare:rightX] == kCFCompareGreaterThan){
            [self removeFromSuperview];
            /** 向控制器发送通知，加载下一个数据 */
            if (self.leftMoveRemoveSelf) {
                self.leftMoveRemoveSelf();
            }
        }else{
            /** 如果滑动距离不够，那么回复初始状态 */
            self.frame = self.originalFrame;
            pan.view.layer.transform = CATransform3DIdentity;
            pan.view.layer.cornerRadius = 0;
            pan.view.layer.masksToBounds = NO;
        }
    }else{
        /** 滑动时缩放视图，并且不断根据拖动触控点位置修改当前视图的中心点 */
        CGPoint point = [pan translationInView:self];
        pan.view.center = CGPointMake(pan.view.center.x + point.x,pan.view.center.y + point.y);
        pan.view.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7);
        pan.view.layer.cornerRadius = 20;
        pan.view.layer.masksToBounds = YES;
        /** 在这里每次都要把拖动距离清零，不然会累加，页面会跑出屏幕外 */
        [pan setTranslation:CGPointZero inView:self];
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
