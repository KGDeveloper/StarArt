//
//  KGBooksView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBooksView.h"
#import "KGBooksDetailVC.h"

@interface KGBooksView ()

@end

@implementation KGBooksView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"KGBooksView" owner:self options:nil];
        self.customView.frame = self.bounds;
        [self addSubview:self.customView];
    }
    return self;
}

- (void)viewDetailWithDictionary:(NSDictionary *)dic{
    [self.customView.booksImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"bookCover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.customView.nameLab.text = dic[@"bookName"];
    self.customView.tag = [dic[@"id"] integerValue];
    self.customView.socreLab.text = [NSString stringWithFormat:@"%@",dic[@"bookScore"]];
    if ([dic[@"bookScore"] integerValue] < 2) {
        self.customView.oneStar.image = [UIImage imageNamed:@"xing"];
        self.customView.twoStar.image = [UIImage imageNamed:@"xingxing"];
        self.customView.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.customView.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.customView.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 3){
        self.customView.oneStar.image = [UIImage imageNamed:@"xing"];
        self.customView.twoStar.image = [UIImage imageNamed:@"xing"];
        self.customView.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.customView.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.customView.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 4){
        self.customView.oneStar.image = [UIImage imageNamed:@"xing"];
        self.customView.twoStar.image = [UIImage imageNamed:@"xing"];
        self.customView.threeStar.image = [UIImage imageNamed:@"xing"];
        self.customView.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.customView.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 5){
        self.customView.oneStar.image = [UIImage imageNamed:@"xing"];
        self.customView.twoStar.image = [UIImage imageNamed:@"xing"];
        self.customView.threeStar.image = [UIImage imageNamed:@"xing"];
        self.customView.fourStar.image = [UIImage imageNamed:@"xing"];
        self.customView.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 6){
        self.customView.oneStar.image = [UIImage imageNamed:@"xing"];
        self.customView.twoStar.image = [UIImage imageNamed:@"xing"];
        self.customView.threeStar.image = [UIImage imageNamed:@"xing"];
        self.customView.fourStar.image = [UIImage imageNamed:@"xing"];
        self.customView.fiveStar.image = [UIImage imageNamed:@"xing"];
    }
    
    
}
/** 获取id */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    KGBooksDetailVC *vc = [[KGBooksDetailVC alloc]init];
    vc.sendID = [NSString stringWithFormat:@"%ld",touch.view.tag];
    [[self supViewController].navigationController pushViewController:vc animated:YES];
}
- (UIViewController *)supViewController{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
