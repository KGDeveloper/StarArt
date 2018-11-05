//
//  KGTalentPrivilegeVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGTalentPrivilegeVC.h"
#import "KGWriteTalentVC.h"

@interface KGTalentPrivilegeVC ()
/** 身份认证 */
@property (weak, nonatomic) IBOutlet UIView *talentView;

@end

@implementation KGTalentPrivilegeVC
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
    self.title = @"星球认证";
    self.view.backgroundColor = KGAreaGrayColor;
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 点击事件 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self.view];
    if (CGRectContainsPoint(CGRectMake(0, KGRectNavAndStatusHight + 20, KGScreenWidth, 50), touchPoint)) {
        [self pushHideenTabbarViewController:[[KGWriteTalentVC alloc]initWithNibName:@"KGWriteTalentVC" bundle:nil] animted:YES];
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
