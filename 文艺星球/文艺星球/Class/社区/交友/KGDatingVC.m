//
//  KGDatingVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDatingVC.h"
#import "KGDatingView.h"
#import "KGDatingManagerVC.h"

@interface KGDatingVC ()

@end

@implementation KGDatingVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"交友";
    [self setDatingView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建聊天 */
- (void)setDatingView{
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 10; i++) {
        KGDatingView *datingView = [[KGDatingView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        datingView.leftMoveRemoveSelf = ^{
            
        };
        datingView.rightMoveStarChat = ^(NSString *userID) {
            [weakSelf pushHideenTabbarViewController:[[KGDatingManagerVC alloc]initWithNibName:@"KGDatingManagerVC" bundle:nil] animted:YES];
        };
        [self.view addSubview:datingView];
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
