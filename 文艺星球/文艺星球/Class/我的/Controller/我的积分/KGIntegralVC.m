//
//  KGIntegralVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGIntegralVC.h"
#import "KGIntegralDetailVC.h"

@interface KGIntegralVC ()
/** 积分 */
@property (weak, nonatomic) IBOutlet UILabel *countLab;
/** 积分详情 */
@property (weak, nonatomic) IBOutlet UIButton *integralDetailBtu;
/** 登录 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtu;
/** 发现 */
@property (weak, nonatomic) IBOutlet UIButton *foundBtu;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
/** 发布 */
@property (weak, nonatomic) IBOutlet UIButton *releaseBtu;
/** 任务情况 */
@property (nonatomic,copy) NSDictionary *taskInfo;

@end

@implementation KGIntegralVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavBackColor:[UIColor clearColor] controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    self.title = @"积分";
    
    self.integralDetailBtu.layer.cornerRadius = 14;
    self.integralDetailBtu.layer.masksToBounds = YES;
    self.integralDetailBtu.layer.borderColor = KGWhiteColor.CGColor;
    self.integralDetailBtu.layer.borderWidth = 1;
    
    [self requestData];
    [self changeBtuGrayColor:self.loginBtu];
    [self changeBtuGrayColor:self.foundBtu];
    [self changeBtuWhiteColor:self.commentBtu];
    [self changeBtuWhiteColor:self.releaseBtu];
}
/** 请求首页数据 */
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequest postWithUrl:FindIntegerHomePage parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.taskInfo = result[@"data"];
            [weakSelf changeBtu];
        }
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 修改页面状态 */
- (void)changeBtu{
    self.countLab.text = [NSString stringWithFormat:@"%@",self.taskInfo[@"count"]];
    if ([self.taskInfo[@"goodPlace"] isEqualToString:@"已完成"]) {
        [self changeBtuGrayColor:self.foundBtu];
    }else{
        [self changeBtuWhiteColor:self.foundBtu];
    }
    if ([self.taskInfo[@"login"] isEqualToString:@"已完成"]) {
        [self changeBtuGrayColor:self.loginBtu];
    }else{
        [self changeBtuWhiteColor:self.loginBtu];
    }
    if ([self.taskInfo[@"fabu"] isEqualToString:@"已完成"]) {
        [self changeBtuGrayColor:self.releaseBtu];
    }else{
        [self changeBtuWhiteColor:self.releaseBtu];
    }
    if ([self.taskInfo[@"comment"] isEqualToString:@"已完成"]) {
        [self changeBtuGrayColor:self.commentBtu];
    }else{
        [self changeBtuWhiteColor:self.commentBtu];
    }
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 修改为已完成 */
- (void)changeBtuGrayColor:(UIButton *)changeBtu{
    [self changeBtuTitle:@"已完成" color:KGWhiteColor backColor:KGGrayColor btu:changeBtu];
}
/** 修改为未完成 */
- (void)changeBtuWhiteColor:(UIButton *)changeBtu{
    [self changeBtuTitle:@"未完成" color:KGBlueColor backColor:KGWhiteColor btu:changeBtu];
}
/** 改变颜色标题(1:背景灰色，边框灰色，字体白色(已领取) 2:背景蓝色，边框蓝色，字体白色(领取) 3:背景白色，边框蓝色，字体蓝色(去完成)) */
- (void)changeBtuTitle:(NSString *)title color:(UIColor *)color backColor:(UIColor *)backColor btu:(UIButton *)btu{
    [btu setTitle:title forState:UIControlStateNormal];
    [btu setTitleColor:color forState:UIControlStateNormal];
    if ([backColor isEqual:KGWhiteColor]) {
        btu.layer.borderColor = KGBlueColor.CGColor;
    }else{
        btu.backgroundColor = backColor;
        btu.layer.borderColor = backColor.CGColor;
    }
}
/** 积分详情 */
- (IBAction)detailAction:(UIButton *)sender {
    [self pushHideenTabbarViewController:[[KGIntegralDetailVC alloc]init] animted:YES];
}
/** 登录领取 */
- (IBAction)loginAction:(UIButton *)sender {
}
/** 发现好去处领取 */
- (IBAction)foundAction:(UIButton *)sender {
}
/** 评论领取 */
- (IBAction)commentAction:(UIButton *)sender {
}
/** 发布领取 */
- (IBAction)releaseAction:(UIButton *)sender {
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
