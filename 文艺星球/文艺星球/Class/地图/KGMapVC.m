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
#import "KGSelectLeftNavChooseCityView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "KGLockUserInfoVC.h"
#import "KGScreenNearPersonVC.h"
#import "KGLockUserInfoVC.h"

@interface KGMapVC ()<CLLocationManagerDelegate,UIWebViewDelegate>

@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *centerBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) KGNearInstatutionVC *instatutionVC;
@property (nonatomic,strong) KGNearConsumptionVC *consumptionVC;
/** 当前显示页面 */
@property (nonatomic,assign) NSInteger selectIndex;
/** 选择城市 */
@property (nonatomic,strong) KGSelectLeftNavChooseCityView *chooseCityView;
@property (nonatomic,copy) NSString *chooseCityID;
/** 附近的人 */
@property (nonatomic,strong) UIWebView *nearPersonView;
@property (nonatomic,strong) JSContext *jsContext;

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
    
    [self setNavCenterView];
    [self loadHTMLFaile];
    
}
/** 导航栏返回按钮点击事件 */
- (void)leftNavAction{
    self.chooseCityView.hidden = NO;
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    switch (self.selectIndex) {
        case 0:
            [self pushNearPersonVC];
            break;
            
        case 1:
            [self.instatutionVC addScreenViewToSupView:self.tabBarController.view topViewHeight:KGRectNavAndStatusHight];
            break;
            
        case 2:
            [self.consumptionVC addScreenViewToSupView:self.tabBarController.view topViewHeight:KGRectNavAndStatusHight];
            break;
        default:
            break;
    }
}
/** 附近的人筛选跳转 */
- (void)pushNearPersonVC{
    KGScreenNearPersonVC *vc = [[KGScreenNearPersonVC alloc]initWithNibName:@"KGScreenNearPersonVC" bundle:[NSBundle mainBundle]];
    [self pushHideenTabbarViewController:vc animted:YES];
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
/** 选择城市 */
- (KGSelectLeftNavChooseCityView *)chooseCityView{
    if (!_chooseCityView) {
        _chooseCityView = [[KGSelectLeftNavChooseCityView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, 100, 350)];
        __weak typeof(self) weakSelf = self;
        _chooseCityView.chooseResult = ^(NSString * _Nonnull result, NSString * _Nonnull cityId) {
            [weakSelf.leftNavItem setTitle:result forState:UIControlStateNormal];
            weakSelf.chooseCityID = cityId;
        };
        [self.navigationController.view addSubview:_chooseCityView];
    }
    return _chooseCityView;
}
// MARK: --创建首页加载附近的人HTML文件--
- (void)loadHTMLFaile{
    self.nearPersonView = [[UIWebView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, kScreenWidth, kScreenHeight - KGRectNavAndStatusHight - KGRectTabbarHeight)];
    self.nearPersonView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.nearPersonView.scrollView.scrollEnabled = NO;
    self.nearPersonView.delegate = self;
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"星球吸引/shandian.html"] withExtension:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"?token=%@",[KGUserInfo shareInstance].userToken] relativeToURL:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.nearPersonView loadRequest:request];
    [self.view addSubview:self.nearPersonView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    __weak typeof(self) weakSelf = self;
    _jsContext = [self.nearPersonView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        
    };
    _jsContext[@"chatWithUserID"] = ^(NSString *uid,NSString *username) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            KGLockUserInfoVC *vc = [[KGLockUserInfoVC alloc]init];
            vc.sendID = uid;
            [weakSelf pushHideenTabbarViewController:vc animted:YES];
        });
    };
    
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
