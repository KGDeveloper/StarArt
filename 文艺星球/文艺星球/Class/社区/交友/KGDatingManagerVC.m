//
//  KGDatingManagerVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDatingManagerVC.h"
#import "KGDatingReportVC.h"

@interface KGDatingManagerVC ()

@end

@implementation KGDatingManagerVC
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
    
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"哈哈哈";
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 举报按钮 */
- (IBAction)reportAction:(UIButton *)sender {
    KGDatingReportVC *vc = [[KGDatingReportVC alloc]initWithNibName:@"KGDatingReportVC" bundle:nil];
    vc.sendID = self.sendID;
    vc.typeStr = @"好友";
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 关注按钮 */
- (IBAction)focusAction:(UIButton *)sender {
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [KGRequest postWithUrl:Attorcel parameters:@{@"toId":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"关注成功"] hideAnimated:YES afterDelay:1];
        }else{
            [[KGHUD showMessage:@"关注失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"访问服务器失败"] hideAnimated:YES afterDelay:1];
    }];
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
