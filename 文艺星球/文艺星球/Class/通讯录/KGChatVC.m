//
//  KGChatVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/11.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGChatVC.h"
#import "KGDatingManagerVC.h"

@interface KGChatVC ()

@end

@implementation KGChatVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:KGBlackColor,NSFontAttributeName:KGFontSHRegular(15)}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KGWhiteColor] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtu];
    [self setRightBtu];
    
}
/** 导航栏设置 */
- (void)setLeftBtu{
    UIButton *leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtu.frame = CGRectMake(15, 0, 70, 30);
    leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtu setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftBtu addTarget:self action:@selector(leftNavAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:leftBtu]];
}
/** 点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧设置 */
- (void)setRightBtu{
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(15, 0, 70, 30);
    rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtu setImage:[UIImage imageNamed:@"guanli"] forState:UIControlStateNormal];
    [rightBtu addTarget:self action:@selector(rightNavAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:rightBtu]];
}
/** 点击事件 */
- (void)rightNavAction{
    KGDatingManagerVC *vc = [[KGDatingManagerVC alloc]init];
    vc.sendID = self.targetId;
    [self.navigationController pushViewController:vc animated:YES];
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
