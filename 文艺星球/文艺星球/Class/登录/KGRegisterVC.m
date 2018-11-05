//
//  KGRegisterVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/23.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGRegisterVC.h"
#import "KGTabbarVC.h"

@interface KGRegisterVC ()
/** 昵称 */
@property (weak, nonatomic) IBOutlet UITextField *nikName;
/** 生日 */
@property (weak, nonatomic) IBOutlet UIButton *birthdayLab;
/** 选择男 */
@property (weak, nonatomic) IBOutlet UIButton *manBtu;
/** 选择女 */
@property (weak, nonatomic) IBOutlet UIButton *womanBtu;
/** 选择保密 */
@property (weak, nonatomic) IBOutlet UIButton *knowBtu;
/** 登录 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtu;
/** 加载view */
@property (weak, nonatomic) IBOutlet UIView *backView;
/** 选择生日view */
@property (nonatomic,strong) KGBirthdayView *birthdayView;

@end

@implementation KGRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    /** 设置登录按钮圆角 */
    self.loginBtu.layer.cornerRadius = 17.5;
    self.loginBtu.layer.masksToBounds = YES;
    self.loginBtu.userInteractionEnabled = YES;
    /** 背景view设置阴影以及圆角 */
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shadowColor = KGBlueColor.CGColor;
    self.backView.layer.shadowOpacity = 0.8f;
    self.backView.layer.shadowRadius = 6.5;
    self.backView.layer.shadowOffset = CGSizeMake(0, 0);
    
}
/** 左侧导航栏点击事件 */
- (IBAction)leftAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 选择生日 */
- (IBAction)selectBirthday:(UIButton *)sender {
    self.birthdayView.hidden = NO;
}
/** 选择男 */
- (IBAction)chooseMan:(UIButton *)sender {
    [self.manBtu setImage:[UIImage imageNamed:@"xuanzhongyuan"] forState:UIControlStateNormal];
    [self.manBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.womanBtu setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [self.womanBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.knowBtu setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [self.knowBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
}
/** 选择女 */
- (IBAction)chooseWoman:(UIButton *)sender {
    [self.womanBtu setImage:[UIImage imageNamed:@"xuanzhongyuan"] forState:UIControlStateNormal];
    [self.womanBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.manBtu setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [self.manBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.knowBtu setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [self.knowBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
}
/** 选择保密 */
- (IBAction)chooseKnow:(UIButton *)sender {
    [self.knowBtu setImage:[UIImage imageNamed:@"xuanzhongyuan"] forState:UIControlStateNormal];
    [self.knowBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.womanBtu setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [self.womanBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.manBtu setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [self.manBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
}
/** 登录 */
- (IBAction)loginAction:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[KGTabbarVC alloc]init];
}
/** 选择生日view */
- (KGBirthdayView *)birthdayView{
    if (!_birthdayView) {
        _birthdayView = [[KGBirthdayView alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 200, kScreenWidth, 200)];
        __weak typeof(self) weakSelf = self;
        _birthdayView.chooseBirthdayString = ^(NSString * _Nonnull birthday, NSString * _Nonnull constellation) {
            [weakSelf.birthdayLab setTitle:[NSString stringWithFormat:@"%@ %@",birthday,constellation] forState:UIControlStateNormal];
            [weakSelf.birthdayLab setTitleColor:KGBlueColor forState:UIControlStateNormal];
        };
        [self.view insertSubview:_birthdayView atIndex:99];
    }
    return _birthdayView;
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
