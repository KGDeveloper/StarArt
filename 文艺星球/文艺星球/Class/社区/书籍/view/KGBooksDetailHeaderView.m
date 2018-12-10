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
        self.markView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
    }
    return self;
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
/** 填写内容 */
- (void)viewDetailWithDictionary:(NSDictionary *)dic{
    [self.customBackImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"bookCover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.markView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.8];
    [self.booksImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"bookCover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.workerNameLab.text = [NSString stringWithFormat:@"作者：%@",dic[@"bookAuthor"]];
    self.pressLab.text = [NSString stringWithFormat:@"出版社：%@",dic[@"bookPress"]];
    self.pressTimeLab.text = [NSString stringWithFormat:@"出版时间：%@",dic[@"bookTime"]];
    self.bookName.text = dic[@"bookName"];
    self.bookIntroudceLab.text = dic[@"bookIntroduction"];
    [self.workerPhotoImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"authorPhoto"] componentsSeparatedByString:@"#"] firstObject]]];
    self.workerLab.text = [NSString stringWithFormat:@"作者：%@",dic[@"bookAuthor"]];
    self.brithdayLab.text = [NSString stringWithFormat:@"出生日期：%@",dic[@"authorTime"]];
    self.magnumOpusLab.text = [NSString stringWithFormat:@"代表作：%@",dic[@"authorMasterpiece"]];
    self.commendLab.text = [NSString stringWithFormat:@"全部评论（%@）",dic[@"commentSum"]];
    NSDictionary *userDic = dic[@"comment"];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:[[userDic[@"portraituri"] componentsSeparatedByString:@"#"] firstObject]]];
    self.userNameLab.text = userDic[@"username"];
    self.userCommendLab.text = userDic[@"comment"];
    self.userTimeLab.text = userDic[@"commentTime"];
    self.scroeLab.text = [NSString stringWithFormat:@"%@",dic[@"bookScore"]];
    [self.userZansBtu setTitle:[NSString stringWithFormat:@"%@",userDic[@"goodSum"]] forState:UIControlStateNormal];
    if (![userDic[@"id"] isKindOfClass:[NSNull class]]) {
        self.userZansBtu.tag = [userDic[@"id"] integerValue];
    }
    if ([dic[@"bookScore"] integerValue] < 2) {
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xingxing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 3){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xingxing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 4){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xingxing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 5){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xing"];
        self.fiveStar.image = [UIImage imageNamed:@"xingxing"];
    }else if ([dic[@"bookScore"] integerValue] < 6){
        self.oneStar.image = [UIImage imageNamed:@"xing"];
        self.twoStar.image = [UIImage imageNamed:@"xing"];
        self.threeStar.image = [UIImage imageNamed:@"xing"];
        self.fourStar.image = [UIImage imageNamed:@"xing"];
        self.fiveStar.image = [UIImage imageNamed:@"xing"];
    }
}
- (IBAction)zansAction:(UIButton *)sender {
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    if (sender.tag != nil) {
        [KGRequest postWithUrl:AddCommentLikeStatusByCid parameters:@{@"cid":@(sender.tag)} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"操作成功"] hideAnimated:YES afterDelay:1];
                if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan"]]) {
                    [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
                }else{
                    [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
                }
            }else{
                [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }];
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
