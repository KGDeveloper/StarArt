//
//  KGLoginVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGLoginVC.h"
#import "KGWYXQUserAgreementVC.h"
#import "KGWYXQPrivacyAgreementVC.h"
#import "KGRegisterVC.h"
#import "KGTabbarVC.h"

@interface KGLoginVC ()<UITextFieldDelegate>{
    NSTimer *_timer;
    NSInteger _count;
    UIButton *readBtu;
}
/** 发送验证码 */
@property (nonatomic,strong) UIButton *sendSMS;
/** 登录按钮 */
@property (nonatomic,strong) UIButton *loginBtu;
/** 手机号 */
@property (nonatomic,strong) UITextField *phoneTF;
/** 验证码 */
@property (nonatomic,strong) UITextField *passTF;
/** 提示图片 */
@property (nonatomic,strong) KGAlertView *alertView;


@end

@implementation KGLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setLoginUI];
}
/** 登录页面 */
- (void)setLoginUI{
    
    /** 背景图片 */
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/375*250)];
    backImageView.image = [UIImage imageNamed:@"登录背景图"];
    [self.view addSubview:backImageView];
    /** 登录标签 */
    UILabel *loginLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 90, KGScreenWidth - 60, 22)];
    loginLab.text = @"登录";
    loginLab.textColor = KGWhiteColor;
    loginLab.font = KGFontSHRegular(22);
    [self.view addSubview:loginLab];
    /** 绘制登录框 */
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 155, KGScreenWidth - 30, (KGScreenWidth - 30)/690*520)];
    whiteView.backgroundColor = KGWhiteColor;
    whiteView.layer.cornerRadius = 10;
    whiteView.layer.masksToBounds = NO;
    whiteView.layer.shadowColor = KGBlueColor.CGColor;
    whiteView.layer.shadowOpacity = 0.8f;
    whiteView.layer.shadowRadius = 6.5;
    whiteView.layer.shadowOffset = CGSizeMake(0, 0);
    [self.view addSubview:whiteView];
    /** 输入手机号 */
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(40, 195, KGScreenWidth - 80, 30)];
    self.phoneTF.placeholder = @"输入手机号";
    self.phoneTF.textColor = KGBlackColor;
    self.phoneTF.font = KGFontSHRegular(14);
    self.phoneTF.delegate = self;
    [self.view addSubview:self.phoneTF];
    /** 输入手机号下划线 */
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(40, 225, KGScreenWidth - 80, 1)];
    topLine.backgroundColor = KGGrayColor;
    [self.view addSubview:topLine];
    /** 输入验证码 */
    self.passTF = [[UITextField alloc]initWithFrame:CGRectMake(40, 260, 200, 30)];
    self.passTF.placeholder = @"输入验证码";
    self.passTF.textColor = KGBlackColor;
    self.passTF.font = KGFontSHRegular(14);
    self.passTF.delegate = self;
    [self.view addSubview:self.passTF];
    /** 验证码下划线 */
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(40, 290, KGScreenWidth - 80, 1)];
    lowLine.backgroundColor = KGGrayColor;
    [self.view addSubview:lowLine];
    /** 获取验证码 */
    self.sendSMS = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendSMS.frame = CGRectMake(KGScreenWidth - 130, 260, 90, 30);
    [self.sendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.sendSMS setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.sendSMS.titleLabel.font = KGFontSHRegular(14);
    self.sendSMS.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.sendSMS addTarget:self action:@selector(requestSMS:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendSMS];
    /** 登录按钮 */
    self.loginBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtu.frame = CGRectMake(40, 340, KGScreenWidth - 80, 35);
    [self.loginBtu setTitle:@"立即开启" forState:UIControlStateNormal];
    [self.loginBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    self.loginBtu.titleLabel.font = KGFontSHRegular(15);
    self.loginBtu.backgroundColor = KGGrayColor;
    [self.loginBtu addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtu.layer.cornerRadius = 17.5;
    self.loginBtu.layer.masksToBounds = YES;
    self.loginBtu.userInteractionEnabled = NO;
    [self.view addSubview:self.loginBtu];
    /** 阅读协议 */
    readBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    readBtu.frame = CGRectMake(40, 385, 10, 10);
    [readBtu setImage:[UIImage imageNamed:@"协议选择框"] forState:UIControlStateNormal];
    [readBtu addTarget:self action:@selector(readIngAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readBtu];
    /** 协议标签 */
    YYLabel *agreementLab = [[YYLabel alloc]initWithFrame:CGRectMake(60, 385, kScreenWidth - 100, 12)];
    [self.view addSubview:agreementLab];
    /** 设置富文本 */
    NSString *string = @"我已阅读并同意《用户协议》和《隐私协议》";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    attributedString.alignment = NSTextAlignmentLeft;
    attributedString.font = KGFontSHRegular(10);
    attributedString.color = KGBlackColor;
    [attributedString setColor:KGBlueColor range:[string rangeOfString:@"《用户协议》"]];
    [attributedString setColor:KGBlueColor range:[string rangeOfString:@"《隐私协议》"]];
    __weak typeof(self) weakSelf = self;
    /** 点击用户协议 */
    [attributedString setTextHighlightRange:[string rangeOfString:@"《用户协议》"] color:KGBlueColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:[[UINavigationController alloc]initWithRootViewController:[[KGWYXQUserAgreementVC alloc]init]] animated:YES completion:nil];
        });
    }];
    /** 点击隐私协议 */
    [attributedString setTextHighlightRange:[string rangeOfString:@"《隐私协议》"] color:KGBlueColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:[[UINavigationController alloc]initWithRootViewController:[[KGWYXQPrivacyAgreementVC alloc]init]] animated:YES completion:nil];
        });
    }];
    agreementLab.attributedText = attributedString;
    
}
/** 发送验证码点击事件 */
- (void)requestSMS:(UIButton *)sender{
    if (self.phoneTF.text.length == 11) {
        _count = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSMSBtuTitle) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    [self postRequestSMS];
}
/** 请求验证码 */
- (void)postRequestSMS{
    [KGRequest postWithUrl:LoginSMS parameters:@{@"telephone":self.phoneTF.text} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"发送成功，请注意查收"] hideAnimated:YES afterDelay:1];
        }else{
            [[KGHUD showMessage:@"发送失败，请重试"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [[KGHUD showMessage:@"发送失败，请重试"] hideAnimated:YES afterDelay:1];
    }];
}
/** 开始发送验证码倒计时 */
- (void)changeSMSBtuTitle{
    if (_count > 0) {
        _count --;
        [self.sendSMS setTitle:[NSString stringWithFormat:@"%lds",(long)_count] forState:UIControlStateNormal];
    }else{
        _count = 60;
        [_timer invalidate];
        _timer = nil;
        [self.sendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}
/** 登录按钮点击事件 */
- (void)loginAction:(UIButton *)sender{
    if (![readBtu.currentImage isEqual:[UIImage imageNamed:@"协议选择框"]]) {
        [KGRequest postWithUrl:Login parameters:@{@"telephone":self.phoneTF.text,@"msgAuthCode":self.passTF.text} succ:^(id  _Nonnull result) {
            if ([result[@"status"] integerValue] == 200) {
                NSDictionary *dic = result[@"data"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [KGUserInfo saveUserInfoWithDictionary:dic[@"user"]];
                NSDictionary *tmpDic = dic[@"user"];
                if ([tmpDic[@"isRegiste"] integerValue] == 0) {
                    KGRegisterVC *registerVC = [[KGRegisterVC alloc]initWithNibName:@"KGRegisterVC" bundle:nil];
                    [self presentViewController:registerVC animated:YES completion:nil];
                }else{
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    window.rootViewController = [[KGTabbarVC alloc]init];
                }
            }else{
                [[KGHUD showMessage:@"请求失败，请重试！"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [[KGHUD showMessage:@"请求失败，请重试！"] hideAnimated:YES afterDelay:1];
        }];
    }else{
        [[KGHUD showMessage:@"请先阅读并且同意协议"] hideAnimated:YES afterDelay:1];
    }
}
/** 已阅读按钮点击事件 */
- (void)readIngAction:(UIButton *)sender{
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"协议选择框"]]) {
        [sender setImage:[UIImage imageNamed:@"协议选择"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"协议选择框"] forState:UIControlStateNormal];
    }
}
/** 监听键盘 */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.passTF) {
        if (self.phoneTF.text.length == 11 && self.passTF.text.length == 6) {
            self.loginBtu.backgroundColor = KGBlueColor;
            self.loginBtu.userInteractionEnabled = YES;
        }else{
            self.loginBtu.backgroundColor = KGGrayColor;
            self.loginBtu.userInteractionEnabled = NO;
        }
    }else{
        if (self.phoneTF.text.length < 11) {
            self.alertView.frame = CGRectMake(0, 0, 150, 30);
            self.alertView.center = CGPointMake(self.view.center.x, 240);
            self.alertView.hidden = NO;
            self.alertView.alertImage = [UIImage imageNamed:@"shoujihao"];
        }
    }
}
/** 提示图片 */
- (KGAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[KGAlertView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view insertSubview:_alertView atIndex:99];
    }
    return _alertView;
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
