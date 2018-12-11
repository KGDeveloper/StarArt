//
//  KGMapVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGMapVC.h"
#import "KGNearInstatutionVC.h"
#import "KGNearConsumptionVC.h"


@interface KGMapVC ()<CLLocationManagerDelegate>

@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *centerBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) KGNearInstatutionVC *instatutionVC;
@property (nonatomic,strong) KGNearConsumptionVC *consumptionVC;
/** 当前显示页面 */
@property (nonatomic,assign) NSInteger selectIndex;

@end

@implementation KGMapVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftNavItemWithFrame:CGRectZero title:@"北京市" image:[UIImage imageNamed:@"shouyedingwei"] font:KGFontSHRegular(13) color:KGBlackColor select:@selector(leftNavAction)];
    [self setRightNavItemWithFrame:CGRectZero title:@"筛选" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    self.selectIndex = 0;
    
    [self requestLocationManager];
    [self setNavCenterView];
    
}
/** 请求权限 */
- (void)requestLocationManager{
    CLLocationManager *manager = [CLLocationManager new];
    manager.delegate = self;
    [manager requestAlwaysAuthorization];
}
/** 返回结果 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusDenied:
            [[KGHUD showMessage:@"无法定位，因为你拒绝位置访问"] hideAnimated:YES afterDelay:1];
            break;
        default:
            break;
    }
}
/** 导航栏返回按钮点击事件 */
- (void)leftNavAction{
    
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    switch (self.selectIndex) {
        case 0:
            
            break;
            
        case 1:
            [self.instatutionVC addScreenViewToSupView:self.tabBarController.view topViewHeight:KGRectNavAndStatusHight];
            break;
            
        case 2:
            
            break;
        default:
            break;
    }
}
/** 导航栏设置 */
- (void)setNavCenterView{
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 105, 0, 210, 32)];
    self.navigationItem.titleView = centerView;
    
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtu.frame = CGRectMake(0, 0, 70, 30);
    [self.leftBtu setTitle:@"附近的人" forState:UIControlStateNormal];
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.leftBtu.titleLabel.font = KGFontSHBold(14);
    [self.leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:self.leftBtu];
    
    self.centerBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtu.frame = CGRectMake(70, 0, 70, 30);
    [self.centerBtu setTitle:@"文化场所" forState:UIControlStateNormal];
    [self.centerBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.centerBtu.titleLabel.font = KGFontSHBold(14);
    [self.centerBtu addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:self.centerBtu];
    
    self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtu.frame = CGRectMake(140, 0, 70, 30);
    [self.rightBtu setTitle:@"文艺消费" forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.rightBtu.titleLabel.font = KGFontSHBold(14);
    [self.rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:self.rightBtu];
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(5, 30, 60, 2)];
    self.line.backgroundColor = KGBlueColor;
    [centerView addSubview:self.line];
}
/** 左侧按钮 */
- (void)leftAction:(UIButton *)leftBtu{
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.centerBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = self.leftBtu.centerX;
    }];
    [self.instatutionVC.view removeFromSuperview];
    [self.consumptionVC.view removeFromSuperview];
    self.selectIndex = 0;
}
/** 中间按钮 */
- (void)centerAction:(UIButton *)leftBtu{
    [self.centerBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.leftBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = self.centerBtu.centerX;
    }];
    [self.view addSubview:self.instatutionVC.view];
    [self.consumptionVC.view removeFromSuperview];
    self.selectIndex = 1;
}
/** 右侧按钮 */
- (void)rightAction:(UIButton *)leftBtu{
    [self.leftBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.centerBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = self.rightBtu.centerX;
    }];
    [self.view addSubview:self.consumptionVC.view];
    [self.instatutionVC.view removeFromSuperview];
    self.selectIndex = 2;
}
/** 文化场所 */
- (KGNearInstatutionVC *)instatutionVC{
    if (!_instatutionVC) {
        _instatutionVC = [[KGNearInstatutionVC alloc]init];
        [self.view addSubview:_instatutionVC.view];
    }
    return _instatutionVC;
}
/** 文化消费 */
- (KGNearConsumptionVC *)consumptionVC{
    if (!_consumptionVC) {
        _consumptionVC = [[KGNearConsumptionVC alloc]init];
        [self.view addSubview:_consumptionVC.view];
    }
    return _consumptionVC;
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
