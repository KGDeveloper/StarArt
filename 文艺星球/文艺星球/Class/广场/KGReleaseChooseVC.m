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
    [self changeNavBackColor:[UIColor clearColor] controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    
    self.view.backgroundColor = KGWhiteColor;
    
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUI{
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    backImage.image = [UIImage imageNamed:@"beijingtu"];
    backImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:backImage];
    
    UIButton *foundBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    foundBtu.frame = CGRectMake(50, 400, 50, 50);
    foundBtu.center = CGPointMake(KGScreenWidth/4, KGScreenHeight - 350);
    [foundBtu setImage:[UIImage imageNamed:@"haoquchu"] forState:UIControlStateNormal];
    foundBtu.layer.cornerRadius = 25;
    foundBtu.layer.masksToBounds = YES;
    [foundBtu addTarget:self action:@selector(foundAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:foundBtu];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 310, KGScreenWidth/2, 14)];
    leftLab.text = @"发现好去处";
    leftLab.textColor = KGWhiteColor;
    leftLab.font = KGFontSHRegular(14);
    leftLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLab];
    
    UIButton *releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtu.frame = CGRectMake(KGScreenWidth - 100, 400, 50, 50);
    releaseBtu.center = CGPointMake(KGScreenWidth/4*3, KGScreenHeight - 350);
    [releaseBtu setImage:[UIImage imageNamed:@"fabuguangchang"] forState:UIControlStateNormal];
    releaseBtu.layer.cornerRadius = 25;
    releaseBtu.layer.masksToBounds = YES;
    [releaseBtu addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:releaseBtu];
    
    UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectMake(KGScreenWidth/2, KGScreenHeight - 310, KGScreenWidth/2, 14)];
    rightLab.text = @"发布广场";
    rightLab.textColor = KGWhiteColor;
    rightLab.font = KGFontSHRegular(14);
    rightLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLab];
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
