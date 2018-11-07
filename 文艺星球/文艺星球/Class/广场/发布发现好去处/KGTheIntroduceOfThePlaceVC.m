//
//  KGTheIntroduceOfThePlaceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGTheIntroduceOfThePlaceVC.h"

@interface KGTheIntroduceOfThePlaceVC ()<YYTextViewDelegate>
/** 介绍 */
@property (nonatomic,strong) YYTextView *introduceTV;
/** 提示文字 */
@property (nonatomic,strong) UILabel *alertLab;

@end

@implementation KGTheIntroduceOfThePlaceVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"地点简介";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = NO;
    
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendIntroduce) {
        self.sendIntroduce(self.introduceTV.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 页面 */
- (void)setUI{
    self.introduceTV = [[YYTextView alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 20, 50)];
    self.introduceTV.placeholderFont = KGFontSHRegular(14);
    self.introduceTV.placeholderTextColor = KGGrayColor;
    self.introduceTV.placeholderText = @"请输入简介内容";
    self.introduceTV.textColor = KGBlackColor;
    self.introduceTV.font = KGFontSHRegular(14);
    self.introduceTV.delegate = self;
    [self.view addSubview:self.introduceTV];
    /** 提示文字 */
    self.alertLab = [[UILabel alloc]initWithFrame:CGRectMake(15, self.introduceTV.frame.origin.y + 74, KGScreenWidth - 30, 13)];
    self.alertLab.text = @"为地点编写不少于500字的简介";
    self.alertLab.textColor = [UIColor colorWithHexString:@"#cccccc"];
    self.alertLab.font = KGFontSHRegular(13);
    [self.view addSubview:self.alertLab];
    
}
/** 代理 */
- (void)textViewDidChange:(YYTextView *)textView{
    if ([self.introduceTV.text boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(14)} context:nil].size.height < KGScreenHeight/3*2) {
        self.introduceTV.frame = CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 30, [self.introduceTV.text boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(14)} context:nil].size.height);
        self.alertLab.frame = CGRectMake(15, self.introduceTV.frame.origin.y + self.introduceTV.frame.size.height + 60, KGScreenWidth - 30, 13);
    }
}
- (void)textViewDidEndEditing:(YYTextView *)textView{
    if (self.introduceTV.text.length > 0) {
        [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = YES;
    }else{
        [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = NO;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.introduceTV resignFirstResponder];
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
