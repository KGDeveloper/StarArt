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
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
