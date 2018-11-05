//
//  KGWYXQPrivacyAgreementVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/23.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWYXQPrivacyAgreementVC.h"

@interface KGWYXQPrivacyAgreementVC ()

@end

@implementation KGWYXQPrivacyAgreementVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeNavBackColor:KGBlueColor controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftAction)];
    self.title = @"艺文星球科技隐私协议";
    
    /** 显示协议 */
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, KGScreenWidth, KGScreenHeight)];
    scrollView.contentSize = CGSizeMake(KGScreenWidth, KGScreenWidth/375*4827);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    /** 添加协议 */
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/375*4827)];
    imageView.image = [UIImage imageNamed:@"yingsixieyi"];
    [scrollView addSubview:imageView];
}
/** 左侧按钮点击事件 */
- (void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
