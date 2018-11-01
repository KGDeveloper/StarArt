//
//  KGAlertView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/23.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAlertView.h"

@interface KGAlertView (){
    NSTimer *_timer;
    NSInteger _count;
}
/** 加载图 */
@property (nonatomic,strong) UIImageView *alertView;

@end

@implementation KGAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _count = 0;
        [self setUI];
    }
    return self;
}
/** 加载 */
- (void)setUI{
    self.alertView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.alertView];
}
/** 赋值 */
- (void)setAlertImage:(UIImage *)alertImage{
    _alertImage = alertImage;
    self.alertView.frame = self.bounds;
    self.alertView.image = alertImage;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disMissView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
/** 消失判断 */
- (void)disMissView{
    if (_count < 2) {
        _count ++;
    }else{
        [_timer invalidate];
        _timer = nil;
        _count = 0;
        self.hidden = YES;
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
