//
//  KGDatingReportVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDatingReportVC.h"

@interface KGDatingReportVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *oneBtu;
@property (weak, nonatomic) IBOutlet UIButton *twoBtu;
@property (weak, nonatomic) IBOutlet UIButton *threeBtu;
@property (weak, nonatomic) IBOutlet UIButton *fourBtu;
@property (weak, nonatomic) IBOutlet UIButton *returnBtu;
@property (weak, nonatomic) IBOutlet UITextView *describeTV;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeigt;
@property (nonatomic,copy) NSString *contentStr;

@end

@implementation KGDatingReportVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"举报";
    self.describeTV.delegate = self;
    self.contentStr = @"";
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightNavAction{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    if (![self.typeStr isEqualToString:@"新闻"]) {
        [KGRequest postWithUrl:SaveUserReport parameters:@{@"bid":self.sendID,@"uid":[KGUserInfo shareInstance].userId,@"report":self.describeTV.text,@"remark":self.contentStr} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"举报成功"] hideAnimated:YES afterDelay:1];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"举报失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"请求失败"] hideAnimated:YES afterDelay:1];
        }];
    }else{
        [KGRequest postWithUrl:AddNewsReportByNid parameters:@{@"nid":self.sendID,@"comment":self.contentStr,@"description":self.describeTV.text} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"举报成功"] hideAnimated:YES afterDelay:1];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"举报失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"请求失败"] hideAnimated:YES afterDelay:1];
        }];
    }
}
/** 举报淫秽色情 */
- (IBAction)oneAction:(UIButton *)sender {
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.returnBtu.hidden = NO;
        self.topHeigt.constant = 0;
        self.contentStr = sender.currentTitle;
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
        self.contentStr = @"";
    }
    [self.twoBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.threeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.fourBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
}
/** 传播违法信息 */
- (IBAction)twoAction:(UIButton *)sender {
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.returnBtu.hidden = NO;
        self.topHeigt.constant = 50;
        self.contentStr = sender.currentTitle;
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
        self.contentStr = @"";
    }
    [self.oneBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.threeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.fourBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
}
/** 营销广告 */
- (IBAction)threeAction:(UIButton *)sender {
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.returnBtu.hidden = NO;
        self.topHeigt.constant = 100;
        self.contentStr = sender.currentTitle;
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
        self.contentStr = @"";
    }
    [self.twoBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.oneBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.fourBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
}
/** 恶意攻击谩骂 */
- (IBAction)fourAction:(UIButton *)sender {
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.returnBtu.hidden = NO;
        self.topHeigt.constant = 150;
        self.contentStr = sender.currentTitle;
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
        self.contentStr = @"";
    }
    [self.twoBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.threeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.oneBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
}
/** 撤销 */
- (IBAction)undoAction:(UIButton *)sender {
    if ([self.oneBtu.currentTitleColor isEqual:KGBlueColor]) {
        [self.oneBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    if ([self.twoBtu.currentTitleColor isEqual:KGBlueColor]) {
        [self.twoBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    if ([self.threeBtu.currentTitleColor isEqual:KGBlueColor]) {
        [self.threeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    if ([self.fourBtu.currentTitleColor isEqual:KGBlueColor]) {
        [self.fourBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    self.contentStr = @"";
    sender.hidden = YES;
}
/** 计算字数 */
- (void)textViewDidChange:(UITextView *)textView{
    self.countLab.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入不少于10个字的描述"]) {
        self.describeTV.text = @"";
        self.describeTV.textColor = KGBlackColor;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1) {
        self.describeTV.text = @"请输入不少于10个字的描述";
        self.describeTV.textColor = [UIColor colorWithHexString:@"#cccccc"];
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
