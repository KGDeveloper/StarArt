//
//  KGFoundReleaseHomeVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFoundReleaseHomeVC.h"
#import "KGSubmitLocationInfoVC.h"

@interface KGFoundReleaseHomeVC ()

@end

@implementation KGFoundReleaseHomeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGBlueColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"推荐好去处";
    self.view.backgroundColor = KGWhiteColor;
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addAction:(UIButton *)sender {
    [self pushHideenTabbarViewController:[[KGSubmitLocationInfoVC alloc]init] animted:YES];
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
