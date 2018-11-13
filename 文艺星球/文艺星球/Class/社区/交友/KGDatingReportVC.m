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
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 举报淫秽色情 */
- (IBAction)oneAction:(UIButton *)sender {
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.returnBtu.hidden = NO;
        self.topHeigt.constant = 0;
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
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
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
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
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
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
    }else{
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        self.returnBtu.hidden = YES;
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
}
/** 计算字数 */
- (void)textViewDidChange:(UITextView *)textView{
    self.countLab.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length];
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
