//
//  KGBusinessHoursOfThePlaceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBusinessHoursOfThePlaceVC.h"

@interface KGBusinessHoursOfThePlaceVC ()<UITextFieldDelegate>
/** 营业时间 */
@property (weak, nonatomic) IBOutlet UITextField *timeTF;

@end

@implementation KGBusinessHoursOfThePlaceVC

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
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"营业时间";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = NO;
    self.timeTF.delegate = self;
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendBusinessTime) {
        self.sendBusinessTime(self.timeTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** UITextFieldDelegate */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.timeTF.text.length > 0) {
        [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = YES;
    }else{
        [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = NO;
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
