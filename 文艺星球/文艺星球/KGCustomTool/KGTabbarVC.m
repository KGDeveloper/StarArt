//
//  KGTabbarVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGTabbarVC.h"
#import "KGMapVC.h"
#import "KGCommunityVC.h"
#import "KGSquareVC.h"
#import "KGFriendsVC.h"
#import "KGMineVC.h"

@interface KGTabbarVC ()

@end

@implementation KGTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBackgroundColor:KGWhiteColor];
    /** 添加地图到控制器 */
    KGMapVC *mapVC = [[KGMapVC alloc]init];
    mapVC.tabBarItem.title = @"地图";
    mapVC.tabBarItem.image = [UIImage imageNamed:@"ditu"];
    mapVC.tabBarItem.selectedImage = [UIImage imageNamed:@"dituselect"];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:mapVC]];
    /** 添加社区到控制器 */
    KGCommunityVC *communityVC = [[KGCommunityVC alloc]init];
    communityVC.tabBarItem.title = @"社区";
    communityVC.tabBarItem.image = [UIImage imageNamed:@"shequ"];
    communityVC.tabBarItem.selectedImage = [UIImage imageNamed:@"shequselect"];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:communityVC]];
    /** 添加广场到控制器 */
    KGSquareVC *squreVC = [[KGSquareVC alloc]init];
    squreVC.tabBarItem.title = @"广场";
    squreVC.tabBarItem.image = [UIImage imageNamed:@"guangchang"];
    squreVC.tabBarItem.selectedImage = [UIImage imageNamed:@"guangchangselect"];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:squreVC]];
    /** 添加通讯录到控制器 */
    KGFriendsVC *friendsVC = [[KGFriendsVC alloc]init];
    friendsVC.tabBarItem.title = @"通讯录";
    friendsVC.tabBarItem.image = [UIImage imageNamed:@"tongxunlu"];
    friendsVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tongxunluselect"];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:friendsVC]];
    /** 添加我的到控制器 */
    KGMineVC *mineVC = [[KGMineVC alloc]init];
    mineVC.tabBarItem.title = @"我的";
    mineVC.tabBarItem.image = [UIImage imageNamed:@"wode"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"wodeselect"];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:mineVC]];
    
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
