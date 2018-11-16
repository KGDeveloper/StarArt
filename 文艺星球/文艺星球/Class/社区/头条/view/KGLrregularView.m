//
//  KGLrregularView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGLrregularView.h"


@interface KGLrregularView ()
/** 遮罩 */
@property (nonatomic,strong) CAShapeLayer *maskLayer;
/** 路径 */
@property (nonatomic,strong) UIBezierPath *borderPath;

@end

@implementation KGLrregularView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.maskLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.maskLayer];
        self.borderPath = [UIBezierPath bezierPath];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.maskLayer.frame = self.bounds;
    /** 起点 */
    [self.borderPath moveToPoint:CGPointMake(0, 12)];
    /** 起点圆角 */
    [self.borderPath addQuadCurveToPoint:CGPointMake(2, 10) controlPoint:CGPointMake(0, 10)];
    /** 起点到三角 */
    [self.borderPath addLineToPoint:CGPointMake(85, 10)];
    [self.borderPath addLineToPoint:CGPointMake(95, 0)];
    [self.borderPath addLineToPoint:CGPointMake(105, 10)];
    [self.borderPath addLineToPoint:CGPointMake(118, 10)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(120, 12) controlPoint:CGPointMake(120, 10)];
    [self.borderPath addLineToPoint:CGPointMake(120, 98)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(118, 100) controlPoint:CGPointMake(120, 100)];
    [self.borderPath addLineToPoint:CGPointMake(2, 100)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, 98) controlPoint:CGPointMake(0, 100)];
    [self.borderPath addLineToPoint:CGPointMake(0, 12)];
    self.maskLayer.path = self.borderPath.CGPath;
    self.maskLayer.fillColor = KGWhiteColor.CGColor;
    self.maskLayer.strokeColor = KGLineColor.CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
