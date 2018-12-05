//
//  KGAgencyDetailAddCommentVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyDetailAddCommentVC.h"

@interface KGAgencyDetailAddCommentVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *oneStar;
@property (weak, nonatomic) IBOutlet UIButton *twoStar;
@property (weak, nonatomic) IBOutlet UIButton *threeStar;
@property (weak, nonatomic) IBOutlet UIButton *fourStar;
@property (weak, nonatomic) IBOutlet UIButton *fiveStar;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;
@property (weak, nonatomic) IBOutlet UILabel *scroeLab;
@property (nonatomic,copy) NSString *scroeStr;

@end

@implementation KGAgencyDetailAddCommentVC

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
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:nil color:KGGrayColor select:@selector(rightNavAction)];
    self.title = @"评分";
    self.rightNavItem.userInteractionEnabled = NO;
    self.view.backgroundColor = KGWhiteColor;
    
    self.commentTV.delegate = self;
    self.commentTV.layer.cornerRadius = 5;
    self.commentTV.layer.borderColor = KGGrayColor.CGColor;
    self.commentTV.layer.borderWidth = 1;
    self.commentTV.layer.masksToBounds = YES;
    
}
/** 导航啦左侧按钮 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧按钮 */
- (void)rightNavAction{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:AddCommunityPlaceCommentByMid parameters:@{@"score":self.scroeStr,@"comment":self.commentTV.text,@"id":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"评价成功"] hideAnimated:YES afterDelay:1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [[KGHUD showMessage:@"评价失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"评价失败"] hideAnimated:YES afterDelay:1];
    }];
}
- (IBAction)oneAction:(UIButton *)sender {
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroeLab.text = @"很差";
    self.scroeStr = @"1";
}
- (IBAction)twoAction:(UIButton *)sender {
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroeLab.text = @"较差";
    self.scroeStr = @"2";
}
- (IBAction)threeAction:(UIButton *)sender {
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroeLab.text = @"一般";
    self.scroeStr = @"3";
}
- (IBAction)fourAction:(UIButton *)sender {
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroeLab.text = @"较好";
    self.scroeStr = @"4";
}
- (IBAction)fiveAction:(UIButton *)sender {
    [self.oneStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fiveStar setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    self.scroeLab.text = @"推荐";
    self.scroeStr = @"5";
}
/** 监听输入 */
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.commentTV.text isEqualToString:@"写几句评价吧..."]) {
        self.commentTV.text = @"";
        self.commentTV.textColor = KGBlackColor;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.commentTV.textColor isEqual:@"写几句评价吧..."] && self.commentTV.text.length < 1) {
        self.commentTV.text = @"写几句评价吧...";
        self.commentTV.textColor = KGGrayColor;
        [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = NO;
    }else{
        [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = YES;
    }
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
