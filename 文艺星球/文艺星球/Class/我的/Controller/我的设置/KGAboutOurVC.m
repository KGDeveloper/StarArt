//
//  KGAboutOurVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAboutOurVC.h"

@interface KGAboutOurVC ()

@end

@implementation KGAboutOurVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHRegular(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"关于我们";
    self.view.backgroundColor = KGWhiteColor;
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 搭建UI */
- (void)setUI{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, 1)];
    line.backgroundColor = KGLineColor;
    [self.view addSubview:line];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 30, 15)];
    nameLab.text = @"联系人：文艺星球官方";
    nameLab.textColor = KGBlackColor;
    nameLab.font = KGFontSHRegular(14);
    [self.view addSubview:nameLab];
    
    UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 50, KGScreenWidth - 30, 15)];
    phoneLab.text = @"邮箱：iap2018@126.com";
    phoneLab.textColor = KGBlackColor;
    phoneLab.font = KGFontSHRegular(14);
    [self.view addSubview:phoneLab];
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
