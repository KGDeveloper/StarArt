//
//  KGWriteTalentInfoVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWriteTalentInfoVC.h"

typedef NS_ENUM(NSInteger,ChoosePhotoType){
    ChoosePhotoTypePositive = 0,
    ChoosePhotoTypeReverse,
    ChoosePhotoTypeWordCard,
};

@interface KGWriteTalentInfoVC ()<UITextFieldDelegate>
/** 行业 */
@property (weak, nonatomic) IBOutlet UITextField *industryTF;
/** 单位 */
@property (weak, nonatomic) IBOutlet UITextField *unitTF;
/** 职位 */
@property (weak, nonatomic) IBOutlet UITextField *positionTF;
/** 选择身份证正面 */
@property (weak, nonatomic) IBOutlet UIButton *idCardPositiveBtu;
/** 选择身份证反面 */
@property (weak, nonatomic) IBOutlet UIButton *idCardReverseBtu;
/** 选择工牌 */
@property (weak, nonatomic) IBOutlet UIButton *wordCardBtu;
/** 完成 */
@property (weak, nonatomic) IBOutlet UIButton *finishBtu;
/** 选择 */
@property (nonatomic,strong) PhotosLibraryView *photoLibary;
/** 选择照片类型 */
@property (nonatomic,assign) ChoosePhotoType chooseType;
/** 认证信息 */
@property (nonatomic,strong) NSMutableDictionary *userDic;
@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,assign) BOOL isSenced;
@property (nonatomic,assign) BOOL isThird;
@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation KGWriteTalentInfoVC
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
    self.title = @"填写认证信息";
    self.view.backgroundColor = KGAreaGrayColor;
    
    /** 页面设置 */
    self.finishBtu.userInteractionEnabled = NO;
    self.industryTF.delegate = self;
    self.unitTF.delegate = self;
    self.positionTF.delegate = self;
    self.userDic = [NSMutableDictionary dictionaryWithDictionary:self.sendDic];
    [self.userDic setObject:[KGUserInfo shareInstance].userId forKey:@"uid"];
    self.isFirst = YES;
    self.isSenced = YES;
    self.isThird = YES;
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 选择身份证正面点击事件 */
- (IBAction)chooseIDCard:(UIButton *)sender {
    self.chooseType = ChoosePhotoTypePositive;
    self.photoLibary.hidden = NO;
}
/** 选择身份证反面点击事件 */
- (IBAction)chooseReverse:(UIButton *)sender {
    self.chooseType = ChoosePhotoTypeReverse;
    self.photoLibary.hidden = NO;
}
/** 选择工牌点击事件 */
- (IBAction)chooseWorkCard:(UIButton *)sender {
    self.chooseType = ChoosePhotoTypeWordCard;
    self.photoLibary.hidden = NO;
}
/** 完成点击事件 */
- (IBAction)finishAction:(UIButton *)sender {
    self.hud = [KGHUD showMessage:@"正在上传..."];
    __weak typeof(self) weakSelf = self;
    if (self.isFirst == NO) {
        dispatch_queue_t queue = dispatch_queue_create("上传身份证正面图片",DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.idCardPositiveBtu.currentImage] result:^(NSString * _Nonnull strPath) {
                [weakSelf.userDic setObject:strPath forKey:@"identityCardFront"];
                weakSelf.isFirst = YES;
                [weakSelf requestData];
            }];
        });
    }
    if (self.isSenced == NO) {
        dispatch_queue_t queue = dispatch_queue_create("上传身份证反面图片",DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.idCardReverseBtu.currentImage] result:^(NSString * _Nonnull strPath) {
                [weakSelf.userDic setObject:strPath forKey:@"identityCardContrary"];
                weakSelf.isSenced = YES;
                [weakSelf requestData];
            }];
        });
    }
    if (self.isThird == NO) {
        dispatch_queue_t queue = dispatch_queue_create("上传证明材料图片",DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.wordCardBtu.currentImage] result:^(NSString * _Nonnull strPath) {
                [weakSelf.userDic setObject:strPath forKey:@"cARTEPROFESSIONELLE"];
                weakSelf.isThird = YES;
                [weakSelf requestData];
            }];
        });
    }
}
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    if (self.isThird == YES && self.isSenced == YES && self.isFirst == YES) {
        [KGRequest postWithUrl:SAVEAlert parameters:self.userDic succ:^(id  _Nonnull result) {
            [weakSelf.hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                NSDictionary *dic = result[@"data"];
                [[KGHUD showMessage:dic[@"success"]] hideAnimated:YES afterDelay:1];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"提交失败！！！"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [weakSelf.hud hideAnimated:YES];
            [[KGHUD showMessage:@"提交失败！！！"] hideAnimated:YES afterDelay:1];
        }];
    }
}
/** 选择照片 */
- (PhotosLibraryView *)photoLibary{
    if (!_photoLibary) {
        _photoLibary = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0,0, KGScreenWidth, KGScreenHeight)];
        _photoLibary.maxCount = 1;
        __weak typeof(self) weakSelf = self;
        _photoLibary.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            switch (weakSelf.chooseType) {
                case ChoosePhotoTypeReverse:
                    [weakSelf.idCardReverseBtu setImage:[imageArr firstObject] forState:UIControlStateNormal];
                    weakSelf.isSenced = NO;
                    break;
                case ChoosePhotoTypePositive:
                    [weakSelf.idCardPositiveBtu setImage:[imageArr firstObject] forState:UIControlStateNormal];
                    weakSelf.isFirst = NO;
                    break;
                case ChoosePhotoTypeWordCard:
                    [weakSelf.wordCardBtu setImage:[imageArr firstObject] forState:UIControlStateNormal];
                    weakSelf.isThird = NO;
                    break;
                default:
                    break;
            }
            [weakSelf changeFinishBtuEnable];
        };
        [self.navigationController.view insertSubview:_photoLibary atIndex:99];
    }
    return _photoLibary;
}
/** 判断是否修改完成按钮交互 */
- (void)changeFinishBtuEnable{
    if (self.industryTF.text.length > 0 && ![self.idCardPositiveBtu.currentImage isEqual:[UIImage imageNamed:@"shenfenzhengfanmian"]] && ![self.idCardReverseBtu.currentImage isEqual:[UIImage imageNamed:@"shenfenzhengzhengmian"]] && ![self.wordCardBtu.currentImage isEqual:[UIImage imageNamed:@"zhiyezhengmingcailiao"]]) {
        self.finishBtu.userInteractionEnabled = YES;
        self.finishBtu.backgroundColor = KGBlueColor;
    }else{
        self.finishBtu.userInteractionEnabled = YES;
        self.finishBtu.backgroundColor = KGBlueColor;
    }
}
/** UITextFieldDelegate */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.industryTF.text > 0) {
        [self.userDic setObject:self.industryTF.text forKey:@"industry"];
    }
    if (self.unitTF.text.length > 0) {
        [self.userDic setObject:self.unitTF.text forKey:@"companyName"];
    }else{
        [self.userDic setObject:@"暂无zan" forKey:@"companyName"];
    }
    if (self.positionTF.text.length > 0) {
        [self.userDic setObject:self.positionTF.text forKey:@"position"];
    }else{
        [self.userDic setObject:@"暂无" forKey:@"position"];
    }
    [self changeFinishBtuEnable];
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
