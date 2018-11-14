//
//  KGBooksDetailHeaderView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBooksDetailHeaderView.h"

@implementation KGBooksDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"KGBooksDetailHeaderView" owner:self options:nil];
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
        
        self.wantToReadBtu.layer.borderColor = KGBlackColor.CGColor;
        self.wantToReadBtu.layer.borderWidth = 1;
        self.readingBtu.layer.borderColor = KGBlackColor.CGColor;
        self.readingBtu.layer.borderWidth = 1;
        self.finishReadBtu.layer.borderColor = KGBlackColor.CGColor;
        self.finishReadBtu.layer.borderWidth = 1;
        self.scoreBtu.layer.borderColor = KGBlackColor.CGColor;
        self.scoreBtu.layer.borderWidth = 1;
        self.markView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
    }
    return self;
}
/** 想要读书 */
- (IBAction)wantToReadAction:(UIButton *)sender {
    if (self.writeMyReview) {
        self.writeMyReview(@"想读");
    }
}
/** 在读书 */
- (IBAction)readingAction:(UIButton *)sender {
    if (self.writeMyReview) {
        self.writeMyReview(@"在读");
    }
}
/** 读过 */
- (IBAction)finishAction:(UIButton *)sender {
    if (self.writeMyReview) {
        self.writeMyReview(@"读过");
    }
}
/** 评分 */
- (IBAction)scoreAction:(UIButton *)sender {
    if (self.writeMyReview) {
        self.writeMyReview(@"评分");
    }
}
/** 我要评分 */
- (IBAction)wantToScroeAction:(UIButton *)sender {
    if (self.writeMyReview) {
        self.writeMyReview(@"我要评分");
    }
}
/** 查看全部评论 */
- (IBAction)lockAllCommendAction:(UIButton *)sender {
    if (self.lockAllCommend) {
        self.lockAllCommend();
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
