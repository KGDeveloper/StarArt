//
//  KGWriteTalentVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWriteTalentVC.h"
#import "KGChooseIDCardView.h"
#import "KGWriteTalentInfoVC.h"

@interface KGWriteTalentVC ()<UITextFieldDelegate>
/** 昵称 */
@property (weak, nonatomic) IBOutlet UITextField *nikeTF;
/** 真实姓名 */
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
/** 手机号 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/** 选择id */
@property (weak, nonatomic) IBOutlet UIButton *chooseIDCardBtu;
/** 填写id */
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
/** 下一页 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtu;
/** 选择证件类型 */
@property (nonatomic,strong) KGChooseIDCardView *chooseID;
/** 认证信息 */
@property (nonatomic,strong) NSMutableDictionary *userDic;

@end

@implementation KGWriteTalentVC
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
    self.title = @"补充基本信息";
    self.view.backgroundColor = KGAreaGrayColor;
    /** 输入框遵守代理 */
    self.nikeTF.delegate = self;
    self.nameTF.delegate = self;
    self.phoneTF.delegate = self;
    self.idCardTF.delegate = self;
    /** 信息没有填写完成之前取消下一页按钮点击事件 */
    self.nextBtu.userInteractionEnabled = NO;
    self.userDic = [NSMutableDictionary dictionaryWithObject:@"二代身份证" forKey:@"papersType"];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 选择证件类型 */
- (IBAction)chooseIdCardType:(UIButton *)sender {
    self.chooseID.hidden = NO;
}
/** 点击进入下一页 */
- (IBAction)nextAction:(UIButton *)sender {
    if (self.userDic.count == 5) {
        KGWriteTalentInfoVC *vc = [[KGWriteTalentInfoVC alloc]initWithNibName:@"KGWriteTalentInfoVC" bundle:nil];
        vc.sendDic = self.userDic.copy;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else{
        [[KGHUD showMessage:@"资料填写不完整"] hideAnimated:YES afterDelay:1];
    }
}
/** 选择器 */
- (KGChooseIDCardView *)chooseID{
    if (!_chooseID) {
        _chooseID = [[KGChooseIDCardView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        __weak typeof(self) weakSelf = self;
        _chooseID.chooseIdCardClass = ^(NSString *className) {
            [weakSelf.userDic setObject:className forKey:@"papersType"];
            [weakSelf.chooseIDCardBtu setTitle:className forState:UIControlStateNormal];
        };
        [self.navigationController.view insertSubview:_chooseID atIndex:99];
    }
    return _chooseID;
}
/** textfielddelegate */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.nikeTF.text.length > 0 && self.nameTF.text.length > 0 && self.phoneTF.text.length > 0 && self.idCardTF.text.length > 0) {
        self.nextBtu.userInteractionEnabled = YES;
        self.nextBtu.backgroundColor = KGBlueColor;
    }else{
        self.nextBtu.userInteractionEnabled = NO;
        self.nextBtu.backgroundColor = KGGrayColor;
    }
    if (textField == self.nikeTF) {
        [self.userDic setObject:self.nikeTF.text forKey:@"userNickname"];
    }
    if (textField == self.nameTF) {
        [self.userDic setObject:self.nameTF.text forKey:@"userName"];
    }
    if (textField == self.phoneTF) {
        [self.userDic setObject:self.phoneTF.text forKey:@"tel"];
    }
    if (textField == self.idCardTF) {
        [self.userDic setObject:self.idCardTF.text forKey:@"identityCardId"];
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
