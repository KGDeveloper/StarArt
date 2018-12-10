//
//  KGWriteReviewVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWriteReviewVC.h"

@interface KGWriteReviewVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *reviewView;
@property (weak, nonatomic) IBOutlet UIButton *oneStar;
@property (weak, nonatomic) IBOutlet UIButton *twoStar;
@property (weak, nonatomic) IBOutlet UIButton *threeStar;
@property (weak, nonatomic) IBOutlet UIButton *fourStar;
@property (weak, nonatomic) IBOutlet UIButton *fiveStar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewHeigt;
@property (weak, nonatomic) IBOutlet UITextView *reviewTV;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (nonatomic,copy) NSString *scoreStr;

@end

@implementation KGWriteReviewVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectMake(15, 0, 50, 30) title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(14) color:KGBlueColor select:@selector(rightNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    self.reviewTV.layer.cornerRadius = 5;
    self.reviewTV.layer.borderWidth = 1;
    self.reviewTV.layer.borderColor = KGGrayColor.CGColor;
    self.reviewTV.layer.masksToBounds = YES;
    self.reviewTV.delegate = self;
    self.scoreStr = @"4";
    
}
/** 导航栏右侧按钮点击事件 */
- (void)rightNavAction{
    if (self.reviewTV.text.length > 1 && ![self.reviewTV.text isEqualToString:@"写几句书评吧..."]) {
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [KGRequest postWithUrl:AddCommentByCidAndUid parameters:@{@"id":self.sendID,@"navigation":@"书评",@"score":self.scoreStr,@"comment":self.reviewTV.text} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"评论成功"] hideAnimated:YES afterDelay:1];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
        }];
    }else{
        [[KGHUD showMessage:@"请写一点点对书籍的评价吧..."] hideAnimated:YES afterDelay:1];
    }
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.reviewTV resignFirstResponder];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"写几句书评吧..."]) {
        self.reviewTV.textColor = KGBlackColor;
        self.reviewTV.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1) {
        self.reviewTV.textColor = KGGrayColor;
        self.reviewTV.text = @"写几句书评吧...";
    }
}
- (IBAction)oneStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"非常差";
    self.scoreStr = @"1";
}
- (IBAction)twoStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"较差";
    self.scoreStr = @"2";
}
- (IBAction)threeStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"一般";
    self.scoreStr = @"3";
}
- (IBAction)fourStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"推荐";
    self.scoreStr = @"4";
}
- (IBAction)fiveStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    self.stateLab.text = @"极力推荐";
    self.scoreStr = @"5";
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
