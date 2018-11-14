//
//  KGWriteReviewVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWriteReviewVC.h"

@interface KGWriteReviewVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *wantToReadBtu;
@property (weak, nonatomic) IBOutlet UIButton *readingBtu;
@property (weak, nonatomic) IBOutlet UIButton *finishBtu;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtu;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *reviewView;
@property (weak, nonatomic) IBOutlet UIButton *oneStar;
@property (weak, nonatomic) IBOutlet UIButton *twoStar;
@property (weak, nonatomic) IBOutlet UIButton *threeStar;
@property (weak, nonatomic) IBOutlet UIButton *fourStar;
@property (weak, nonatomic) IBOutlet UIButton *fiveStar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewHeigt;
@property (weak, nonatomic) IBOutlet UITextView *reviewTV;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;

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
    [self.wantToReadBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.reviewHeigt.constant = 0;
}
/** 导航栏右侧按钮点击事件 */
- (void)rightNavAction{
    
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
- (IBAction)readingAction:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.wantToReadBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.finishBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.scoreBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.reviewHeigt.constant = 100;
}
- (IBAction)wantToReadAction:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.readingBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.finishBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.scoreBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.reviewHeigt.constant = 0;
}
- (IBAction)finishAction:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.wantToReadBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.readingBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.scoreBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.reviewHeigt.constant = 100;
}
- (IBAction)scroeAction:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.wantToReadBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.readingBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.finishBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.reviewHeigt.constant = 100;
}
- (IBAction)oneStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"非常差";
}
- (IBAction)twoStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"较差";
}
- (IBAction)threeStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"一般";
}
- (IBAction)fourStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.stateLab.text = @"推荐";
}
- (IBAction)fiveStarAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    self.stateLab.text = @"极力推荐";
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
