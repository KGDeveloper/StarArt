//
//  KGReleaseChooseVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGReleaseChooseVC.h"
#import "KGReleaseVC.h"
#import "KGFoundReleaseHomeVC.h"

@interface KGReleaseChooseVC ()

@end

@implementation KGReleaseChooseVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"发布";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = YES;
    
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUI{
    UIButton *foundBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    foundBtu.frame = CGRectMake(50, 400, 50, 50);
    foundBtu.backgroundColor = KGLineColor;
    foundBtu.layer.cornerRadius = 25;
    foundBtu.layer.masksToBounds = YES;
    [foundBtu addTarget:self action:@selector(foundAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:foundBtu];
    
    UIButton *releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtu.frame = CGRectMake(KGScreenWidth - 100, 400, 50, 50);
    releaseBtu.backgroundColor = KGLineColor;
    releaseBtu.layer.cornerRadius = 25;
    releaseBtu.layer.masksToBounds = YES;
    [releaseBtu addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:releaseBtu];
}
- (void)foundAction{
    [self pushHideenTabbarViewController:[[KGFoundReleaseHomeVC alloc]initWithNibName:@"KGFoundReleaseHomeVC" bundle:[NSBundle mainBundle]] animted:YES];
}
- (void)releaseAction{
    [self pushHideenTabbarViewController:[[KGReleaseVC alloc]init] animted:YES];
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
