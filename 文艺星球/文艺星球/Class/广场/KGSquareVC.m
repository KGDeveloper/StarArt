//
//  KGSquareVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSquareVC.h"
#import "KGReleaseVC.h"

@interface KGSquareVC ()

@end

@implementation KGSquareVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHRegular(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 导航栏标题 */
    self.title = @"广场";
    self.view.backgroundColor = KGAreaGrayColor;
    
    [self releaseBtu];
}
/** 发布按钮 */
- (void)releaseBtu{
    UIButton *releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtu.frame = CGRectMake(KGScreenWidth - 40, KGScreenHeight - KGRectTabbarHeight - 100, 40, 40);
    [releaseBtu setImage:[UIImage imageNamed:@"fabu"] forState:UIControlStateNormal];
    [releaseBtu addTarget:self action:@selector(releaseAction:) forControlEvents:UIControlEventTouchUpInside];
    releaseBtu.layer.cornerRadius = 20;
    releaseBtu.layer.masksToBounds = YES;
    [self.view insertSubview:releaseBtu atIndex:99];
}
/** 发布按钮点击事件 */
- (void)releaseAction:(UIButton *)sender{
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
