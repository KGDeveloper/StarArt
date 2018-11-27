//
//  KGEditSelfVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGEditSelfVC.h"
#import "KGWriteSignatureVC.h"
#import "KGMyLabelVC.h"
#import "KGHometownVC.h"

typedef NS_ENUM(NSInteger,ChoosePhotoPoisition) {
    ChoosePhotoPoisitionLeft = 0,
    ChoosePhotoPoisitionCenter,
    ChoosePhotoPoisitionRight,
    ChoosePhotoPoisitionheader,
};

@interface KGEditSelfVC ()<KGImageViewDelegate,UITextFieldDelegate>
/** 底部滚动图 */
@property (nonatomic,strong) UIScrollView *backView;
/** 左侧图片 */
@property (nonatomic,strong) KGImageView *leftImage;
/** 中间图片 */
@property (nonatomic,strong) KGImageView *centerImage;
/** 右侧图片 */
@property (nonatomic,strong) KGImageView *rightImage;
/** 选择 */
@property (nonatomic,strong) PhotosLibraryView *photoLibary;
/** 选择照片位置 */
@property (nonatomic,assign) ChoosePhotoPoisition photoPosition;
/** 头像 */
@property (nonatomic,strong) UIButton *headerBtu;
/** 昵称 */
@property (nonatomic,strong) UITextField *nikNameTF;
/** 出生日期 */
@property (nonatomic,strong) UIButton *brithdayBtu;
/** 选择生日view */
@property (nonatomic,strong) KGBirthdayView *birthdayView;
/** 个性签名 */
@property (nonatomic,strong) UIButton *signatureBtu;
/** 行业 */
@property (nonatomic,strong) UITextField *industryTF;
/** 学校 */
@property (nonatomic,strong) UITextField *schoolTF;
/** 家乡 */
@property (nonatomic,strong) UIButton *homeBtu;
/** 我的标签 */
@property (nonatomic,strong) UIButton *myLabelBtu;
/** 选择的标签 */
@property (nonatomic,strong) UIView *chooseLabelView;
/** 用户信息 */
@property (nonatomic,strong) NSMutableDictionary *userDic;
/** 我的标签 */
@property (nonatomic,strong) NSMutableArray *myLabelsArr;

@end

@implementation KGEditSelfVC

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
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"保存" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"编辑资料";
    self.view.backgroundColor = KGAreaGrayColor;
    self.userDic = [NSMutableDictionary dictionary];
    
    [self requestUserInfo];
    [self setScrollView];
    [self setTopImage];
    [self setInfo];
    [self setSelfInfo];
}
/** 查看个人资料 */
- (void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [KGHUD showMessage:@"正在加载......" toView:self.view];
    [KGRequest postWithUrl:[RequestUserInfo stringByAppendingString:[NSString stringWithFormat:@"/%@",[KGUserInfo shareInstance].userId]] parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            [weakSelf changeViewModel:dic];
        }
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    __weak typeof(self) weakSelf = self;
    if (![self.leftImage.image isEqual:[UIImage imageNamed:@"bianjitianjia"]]) {
        if (![self.leftImage.image isEqual:[UIImage imageNamed:@"bianjitianjia"]]) {
            if (![self.leftImage.image isEqual:[UIImage imageNamed:@"bianjitianjia"]]) {
                MBProgressHUD *hud = [KGHUD showMessage:@"正在上传图片..." toView:self.view];
                // 串行队列的创建方法
                dispatch_queue_t queue = dispatch_queue_create("上传图片", DISPATCH_QUEUE_SERIAL);
                dispatch_sync(queue, ^{
                    [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.leftImage.image] result:^(NSString * _Nonnull strPath) {
                        [weakSelf.userDic setObject:strPath forKey:@"dynamicImage1"];
                    }];
                });
                dispatch_sync(queue, ^{
                    [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.centerImage.image] result:^(NSString * _Nonnull strPath) {
                        [weakSelf.userDic setObject:strPath forKey:@"dynamicImage2"];
                    }];
                });
                dispatch_sync(queue, ^{
                    [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.rightImage.image] result:^(NSString * _Nonnull strPath) {
                        [weakSelf.userDic setObject:strPath forKey:@"dynamicImage3"];
                    }];
                });
                [hud hideAnimated:YES afterDelay:1];
                [self changeUserInfo];
            }else{
                [[KGHUD showMessage:@"请选择封面照片"] hideAnimated:YES afterDelay:1];
            }
        }else{
            [[KGHUD showMessage:@"请选择封面照片"] hideAnimated:YES afterDelay:1];
        }
    }else{
        [[KGHUD showMessage:@"请选择封面照片"] hideAnimated:YES afterDelay:1];
    }
}
/** 修改资料 */
- (void)changeUserInfo{
    if (self.userDic.count > 0) {
        __weak typeof(self) weakSelf = self;
        [KGRequest postWithUrl:UpdateUserInfo parameters:self.userDic succ:^(id  _Nonnull result) {
            if ([result[@"status"] integerValue] == 200) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"请求出错，请重试！"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [[KGHUD showMessage:@"请求出错，请重试！"] hideAnimated:YES afterDelay:1];
        }];
    }else{
        [[KGHUD showMessage:@"没有做任何修改，请修改后提交"] hideAnimated:YES afterDelay:1];
    }
}
/** 创建底部滚动图 */
- (void)setScrollView{
    self.backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.backView.backgroundColor = KGWhiteColor;
    self.backView.showsVerticalScrollIndicator = NO;
    self.backView.showsHorizontalScrollIndicator = NO;
    self.backView.bounces = NO;
    self.backView.contentSize = CGSizeMake(KGScreenWidth, 700);
    [self.view addSubview:self.backView];
}
/** 创建顶部封面选择 */
- (void)setTopImage{
    __weak typeof(self) weakSelf = self;
    /** 左侧图片 */
    self.leftImage = [[KGImageView alloc]initWithFrame:CGRectMake(15, 15, 110, 140)];
    self.leftImage.placeholderImage = [UIImage imageNamed:@"bianjitianjia"];
    self.leftImage.allowDelete = YES;
    self.leftImage.allowZoom = NO;
    self.leftImage.deleteImage = [UIImage imageNamed:@"图片编辑"];
    self.leftImage.choosePhotoFromPhotoAlbum = ^{
        weakSelf.photoPosition = ChoosePhotoPoisitionLeft;
        weakSelf.photoLibary.hidden = NO;
    };
    self.leftImage.layer.cornerRadius = 5;
    self.leftImage.layer.masksToBounds = YES;
    [self.backView addSubview:self.leftImage];
    /** 中间图片 */
    self.centerImage = [[KGImageView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 55, 15, 110, 140)];
    self.centerImage.placeholderImage = [UIImage imageNamed:@"bianjitianjia"];
    self.centerImage.allowDelete = YES;
    self.centerImage.allowZoom = NO;
    self.centerImage.deleteImage = [UIImage imageNamed:@"图片编辑"];
    self.centerImage.choosePhotoFromPhotoAlbum = ^{
        weakSelf.photoPosition = ChoosePhotoPoisitionCenter;
        weakSelf.photoLibary.hidden = NO;
    };
    self.centerImage.layer.cornerRadius = 5;
    self.centerImage.layer.masksToBounds = YES;
    [self.backView addSubview:self.centerImage];
    /** 右侧图片 */
    self.rightImage = [[KGImageView alloc]initWithFrame:CGRectMake(KGScreenWidth - 125, 15, 110, 140)];
    self.rightImage.placeholderImage = [UIImage imageNamed:@"bianjitianjia"];
    self.rightImage.allowDelete = YES;
    self.rightImage.allowZoom = NO;
    self.rightImage.deleteImage = [UIImage imageNamed:@"图片编辑"];
    self.rightImage.choosePhotoFromPhotoAlbum = ^{
        weakSelf.photoPosition = ChoosePhotoPoisitionRight;
        weakSelf.photoLibary.hidden = NO;
    };
    self.rightImage.layer.cornerRadius = 5;
    self.rightImage.layer.masksToBounds = YES;
    [self.backView addSubview:self.rightImage];
}
/** KGImageViewDelegate */
- (DeleteImageWithState)deleteUIImage{
    return DeleteImageWithStateOnlyImage;
}
/** 选择照片 */
- (PhotosLibraryView *)photoLibary{
    if (!_photoLibary) {
        _photoLibary = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0,0, KGScreenWidth, KGScreenHeight)];
        _photoLibary.maxCount = 1;
        __weak typeof(self) weakSelf = self;
        _photoLibary.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            switch (weakSelf.photoPosition) {
                case ChoosePhotoPoisitionLeft:
                    weakSelf.leftImage.image = [imageArr firstObject];
                    break;
                case ChoosePhotoPoisitionCenter:
                    weakSelf.centerImage.image = [imageArr firstObject];
                    break;
                case ChoosePhotoPoisitionRight:
                    weakSelf.rightImage.image = [imageArr firstObject];
                    break;
                case ChoosePhotoPoisitionheader:
                    [weakSelf.headerBtu setImage:[imageArr firstObject] forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            
        };
        [self.navigationController.view insertSubview:_photoLibary atIndex:99];
    }
    return _photoLibary;
}
/** 基本资料 */
- (void)setInfo{
    /** 基本信息标签 */
    UILabel *infoLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 180, KGScreenWidth - 30, 13)];
    infoLab.text = @"基本资料";
    infoLab.font = KGFontSHBold(13);
    infoLab.textColor = KGBlackColor;
    [self.backView addSubview:infoLab];
    /** 头像 */
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 195, KGScreenWidth - 30, 60)];
    headerLab.text = @"头像";
    headerLab.font = KGFontSHRegular(13);
    headerLab.textColor = KGBlackColor;
    [self.backView addSubview:headerLab];
    self.headerBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerBtu.frame = CGRectMake(KGScreenWidth - 55, headerLab.center.y-34, 40, 40);
    [self.headerBtu setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    self.headerBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.headerBtu.layer.cornerRadius = 20;
    self.headerBtu.layer.masksToBounds = YES;
    [self.headerBtu addTarget:self action:@selector(headerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.headerBtu];
    /** 分割线 */
    UIView *oneLine = [[UIView alloc]initWithFrame:CGRectMake(15, 240, KGScreenWidth - 30, 1)];
    oneLine.backgroundColor = KGLineColor;
    [self.backView addSubview:oneLine];
    /** 昵称 */
    UILabel *nikeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 240, 60, 50)];
    nikeLab.textColor = KGBlackColor;
    nikeLab.font = KGFontSHRegular(13);
    nikeLab.text = @"昵称";
    [self.backView addSubview:nikeLab];
    self.nikNameTF = [[UITextField alloc]initWithFrame:CGRectMake(85, 240, KGScreenWidth - 100, 50)];
    self.nikNameTF.delegate = self;
    self.nikNameTF.placeholder = @"请输入12个字以内的昵称";
    self.nikNameTF.textColor = KGBlackColor;
    self.nikNameTF.font = KGFontSHRegular(13);
    self.nikNameTF.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.nikNameTF];
    /** 分割线 */
    UIView *twoLine = [[UIView alloc]initWithFrame:CGRectMake(15, 290, KGScreenWidth - 30, 1)];
    twoLine.backgroundColor = KGLineColor;
    [self.backView addSubview:twoLine];
    /** 出生日期 */
    UILabel *brithdayLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 290, 60, 50)];
    brithdayLab.textColor = KGBlackColor;
    brithdayLab.font = KGFontSHRegular(13);
    brithdayLab.text = @"出生日期";
    [self.backView addSubview:brithdayLab];
    self.brithdayBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.brithdayBtu.frame = CGRectMake(85, 290, KGScreenWidth - 120, 50);
    [self.brithdayBtu setTitle:@"请选择出生日期" forState:UIControlStateNormal];
    [self.brithdayBtu setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    self.brithdayBtu.titleLabel.font = KGFontSHRegular(13);
    self.brithdayBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.brithdayBtu addTarget:self action:@selector(chooseBrithdayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.brithdayBtu];
    UIImageView *btuImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dakai"]];
    btuImage.frame = CGRectMake(KGScreenWidth - 25, self.brithdayBtu.center.y-5, 10, 10);
    btuImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.backView addSubview:btuImage];
    /** 分割线 */
    UIView *threeLine = [[UIView alloc]initWithFrame:CGRectMake(15, 340, KGScreenWidth - 30, 1)];
    threeLine.backgroundColor = KGLineColor;
    [self.backView addSubview:threeLine];
    /** 个性签名 */
    UILabel *signatureLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 340, 60, 50)];
    signatureLab.textColor = KGBlackColor;
    signatureLab.font = KGFontSHRegular(13);
    signatureLab.text = @"个性签名";
    [self.backView addSubview:signatureLab];
    self.signatureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signatureBtu.frame = CGRectMake(85, 340, KGScreenWidth - 120, 50);
    [self.signatureBtu setTitle:@"请输入26个字以内个性签名" forState:UIControlStateNormal];
    self.signatureBtu.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.signatureBtu setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    self.signatureBtu.titleLabel.font = KGFontSHRegular(13);
    self.signatureBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.signatureBtu addTarget:self action:@selector(writeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.signatureBtu];
    UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dakai"]];
    rightImage.frame = CGRectMake(KGScreenWidth - 25, self.signatureBtu.center.y-5, 10, 10);
    rightImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.backView addSubview:rightImage];
    /** 分割线 */
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(15, 390, KGScreenWidth - 30, 1)];
    lowLine.backgroundColor = KGLineColor;
    [self.backView addSubview:lowLine];
}
/** 选择头像 */
- (void)headerAction{
    self.photoPosition = ChoosePhotoPoisitionheader;
    self.photoLibary.hidden = NO;
}
/** 选择生日 */
- (void)chooseBrithdayAction{
    self.birthdayView.hidden = NO;
}
/** 选择生日view */
- (KGBirthdayView *)birthdayView{
    if (!_birthdayView) {
        _birthdayView = [[KGBirthdayView alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 200, kScreenWidth, 200)];
        __weak typeof(self) weakSelf = self;
        _birthdayView.chooseBirthdayString = ^(NSString * _Nonnull birthday, NSString * _Nonnull constellation) {
            [weakSelf.userDic setObject:[[[birthday stringByReplacingOccurrencesOfString:@"年" withString:@"-"] stringByReplacingOccurrencesOfString:@"月" withString:@"-"]stringByReplacingOccurrencesOfString:@"日" withString:@""] forKey:@"birthday"];
            [weakSelf.brithdayBtu setTitle:[NSString stringWithFormat:@"%@ (%@)",birthday,constellation] forState:UIControlStateNormal];
            [weakSelf.brithdayBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
        };
        [self.view insertSubview:_birthdayView atIndex:99];
    }
    return _birthdayView;
}
/** 编辑个性签名 */
- (void)writeAction{
    KGWriteSignatureVC *vc = [[KGWriteSignatureVC alloc]init];
    __weak typeof(self) weakSelf = self;
    vc.sendSignature = ^(NSString * _Nonnull signature) {
        [weakSelf.userDic setObject:signature forKey:@"personalitySignature"];
        [weakSelf.signatureBtu setTitle:signature forState:UIControlStateNormal];
        [weakSelf.signatureBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    };
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 个人资料 */
- (void)setSelfInfo{
    /** 个人资料标签 */
    UILabel *infoLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 415, KGScreenWidth - 30, 13)];
    infoLab.text = @"个人资料";
    infoLab.font = KGFontSHBold(13);
    infoLab.textColor = KGBlackColor;
    [self.backView addSubview:infoLab];
    /** 行业 */
    UILabel *nikeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 430, 60, 50)];
    nikeLab.textColor = KGBlackColor;
    nikeLab.font = KGFontSHRegular(13);
    nikeLab.text = @"行业";
    [self.backView addSubview:nikeLab];
    self.industryTF = [[UITextField alloc]initWithFrame:CGRectMake(85, 430, KGScreenWidth - 100, 50)];
    self.industryTF.delegate = self;
    self.industryTF.placeholder = @"请填写从事行业";
    self.industryTF.textColor = KGBlackColor;
    self.industryTF.font = KGFontSHRegular(13);
    self.industryTF.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.industryTF];
    /** 分割线 */
    UIView *oneLine = [[UIView alloc]initWithFrame:CGRectMake(15, 480, KGScreenWidth - 30, 1)];
    oneLine.backgroundColor = KGLineColor;
    [self.backView addSubview:oneLine];
    /** 学校 */
    UILabel *schoolLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 480, 60, 50)];
    schoolLab.textColor = KGBlackColor;
    schoolLab.font = KGFontSHRegular(13);
    schoolLab.text = @"学校";
    [self.backView addSubview:schoolLab];
    self.schoolTF = [[UITextField alloc]initWithFrame:CGRectMake(85, 480, KGScreenWidth - 100, 50)];
    self.schoolTF.delegate = self;
    self.schoolTF.placeholder = @"请添加学校信息";
    self.schoolTF.textColor = KGBlackColor;
    self.schoolTF.font = KGFontSHRegular(13);
    self.schoolTF.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.schoolTF];
    /** 分割线 */
    UIView *twoLine = [[UIView alloc]initWithFrame:CGRectMake(15, 530, KGScreenWidth - 30, 1)];
    twoLine.backgroundColor = KGLineColor;
    [self.backView addSubview:twoLine];
    /** 家乡 */
    UILabel *homeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 530, 60, 50)];
    homeLab.textColor = KGBlackColor;
    homeLab.font = KGFontSHRegular(13);
    homeLab.text = @"家乡";
    [self.backView addSubview:homeLab];
    self.homeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.homeBtu.frame = CGRectMake(85, 530, KGScreenWidth - 120, 50);
    [self.homeBtu setTitle:@"请选择家乡城市" forState:UIControlStateNormal];
    [self.homeBtu setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    self.homeBtu.titleLabel.font = KGFontSHRegular(13);
    self.homeBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.homeBtu addTarget:self action:@selector(hometownAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.homeBtu];
    UIImageView *btuImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dakai"]];
    btuImage.frame = CGRectMake(KGScreenWidth - 25, self.homeBtu.center.y-5, 10, 10);
    btuImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.backView addSubview:btuImage];
    /** 分割线 */
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(15, 580, KGScreenWidth - 30, 1)];
    lowLine.backgroundColor = KGLineColor;
    [self.backView addSubview:lowLine];
    /** 我的标签 */
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 580, 60, 50)];
    myLabel.textColor = KGBlackColor;
    myLabel.font = KGFontSHBold(13);
    myLabel.text = @"我的标签";
    [self.backView addSubview:myLabel];
    self.myLabelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myLabelBtu.frame = CGRectMake(85, 580, KGScreenWidth - 120, 50);
    [self.myLabelBtu setTitle:@"请添加您的标签世界" forState:UIControlStateNormal];
    [self.myLabelBtu setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    self.myLabelBtu.titleLabel.font = KGFontSHRegular(13);
    self.myLabelBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.myLabelBtu addTarget:self action:@selector(mylabelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.myLabelBtu];
    UIImageView *labImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dakai"]];
    labImage.frame = CGRectMake(KGScreenWidth - 25, self.myLabelBtu.center.y-5, 10, 10);
    labImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.backView addSubview:labImage];
}
/** 家乡点击事件 */
- (void)hometownAction{
    KGHometownVC *vc = [[KGHometownVC alloc]init];
    __weak typeof(self) weakSelf = self;
    vc.sendHomeTownToController = ^(NSString * _Nonnull homeTown) {
        [weakSelf.userDic setObject:homeTown forKey:@"hometown"];
        [weakSelf.homeBtu setTitle:homeTown forState:UIControlStateNormal];
        [weakSelf.homeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    };
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 我的标签点击事件 */
- (void)mylabelAction{
    KGMyLabelVC *vc = [[KGMyLabelVC alloc]init];
    vc.oldArr = self.myLabelsArr.copy;
    __weak typeof(self) weakSelf = self;
    vc.sendChooseLabel = ^(NSArray * _Nonnull chooseArr) {
        [weakSelf addLabelToViewWithArr:chooseArr];
        [weakSelf.myLabelsArr addObjectsFromArray:chooseArr];
        [weakSelf addTitle:chooseArr];
    };
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 选择的标签 */
- (void)addTitle:(NSArray *)arr{
    NSMutableArray *tmp = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        [tmp addObject:dic[@"id"]];
    }
    [self.userDic setObject:tmp forKey:@"mylabelIds"];
}
/** 添加选择的标签 */
- (UIView *)chooseLabelView{
    if (!_chooseLabelView) {
        _chooseLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 630, KGScreenWidth, 175)];
        [self.backView addSubview:_chooseLabelView];
    }
    return _chooseLabelView;
}
/** 加载标签 */
- (void)addLabelToViewWithArr:(NSArray *)arr{
    CGFloat width = 15;
    CGFloat height = 0;
    for (int i = 0; i < arr.count; i++) {
        UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(width,height, 100, 20)];
        NSDictionary *dic = arr[i];
        tmpLab.text = dic[@"labelName"];
        tmpLab.textColor = KGWhiteColor;
        tmpLab.font = KGFontSHRegular(13);
        tmpLab.textAlignment = NSTextAlignmentCenter;
        tmpLab.backgroundColor = KGBlueColor;
        tmpLab.layer.cornerRadius = 10;
        tmpLab.layer.masksToBounds = YES;
        tmpLab.layer.borderColor = KGBlueColor.CGColor;
        tmpLab.layer.borderWidth = 1;
        [self.chooseLabelView addSubview:tmpLab];
        if ((i+1)%3 == 0) {
            height = height + 35;
            width = 15;
        }else{
            width = width + 115;
        }
    }
    /** 根据标签个数修改布局 */
    self.chooseLabelView.frame = CGRectMake(0, 630, KGScreenWidth, height + 35);
    self.backView.contentSize = CGSizeMake(KGScreenWidth, 630 + height + 35);
}
// MARK: --设置页面数据--
/** 设置页面参数 */
- (void)changeViewModel:(NSDictionary *)dic{
    /** 设置图片 */
    [self downLoadImageWithURL:@{@"url":dic[@"portraitUri"],@"type":@"Header"}];
    if (![dic[@"dynamicImage1"] isKindOfClass:[NSNull class]]) {
        [self downLoadImageWithURL:@{@"url":dic[@"dynamicImage1"],@"type":@"Left"}];
    }
    if (![dic[@"dynamicImage2"] isKindOfClass:[NSNull class]]) {
        [self downLoadImageWithURL:@{@"url":dic[@"dynamicImage2"],@"type":@"Center"}];
    }
    if (![dic[@"dynamicImage3"] isKindOfClass:[NSNull class]]) {
        [self downLoadImageWithURL:@{@"url":dic[@"dynamicImage3"],@"type":@"Right"}];
    }
    /** 设置名称 */
    self.nikNameTF.text = dic[@"username"];
    if (![dic[@"birthday"] isKindOfClass:[NSNull class]]) {
        [self.brithdayBtu setTitle:dic[@"birthday"] forState:UIControlStateNormal];
        [self.brithdayBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    if (![dic[@"personalitySignature"] isKindOfClass:[NSNull class]]) {
        [self.signatureBtu setTitle:dic[@"personalitySignature"] forState:UIControlStateNormal];
        [self.signatureBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    if (![dic[@"industry"] isKindOfClass:[NSNull class]]) {
        self.industryTF.text = dic[@"industry"];
    }
    if (![dic[@"school"] isKindOfClass:[NSNull class]]) {
        self.schoolTF.text = dic[@"school"];
    }
    if (![dic[@"hometown"] isKindOfClass:[NSNull class]]) {
        [self.homeBtu setTitle:dic[@"hometown"] forState:UIControlStateNormal];
        [self.homeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    NSArray *labelsArr = dic[@"mylabels"];
    if (labelsArr.count > 0) {
        self.myLabelsArr = [NSMutableArray arrayWithArray:labelsArr];
    }
}
/** 异步请求网络图片 */
- (void)downLoadImageWithURL:(NSDictionary *)dic{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(changeImageView:) object:dic];
    [operationQueue addOperation:op];
}
/** 更新页面数据 */
- (void)changeImageView:(NSDictionary *)dic{
    UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"url"]]]];
    [self performSelectorOnMainThread:@selector(updataImageView:) withObject:@{@"image":image,@"type":dic[@"type"]} waitUntilDone:YES];
}
/** 刷新页面 */
- (void)updataImageView:(NSDictionary *)dic{
    if ([dic[@"type"] isEqualToString:@"Header"]) {
        [self.headerBtu setImage:dic[@"image"] forState:UIControlStateNormal];
    }
    if ([dic[@"type"] isEqualToString:@"Left"]) {
        self.leftImage.image = dic[@"image"];
    }
    if ([dic[@"type"] isEqualToString:@"Center"]) {
        self.centerImage.image = dic[@"image"];
    }
    if ([dic[@"type"] isEqualToString:@"Right"]) {
        self.rightImage.image = dic[@"image"];
    }
}
/** 监听键盘输入 */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 1) {
        if (textField == self.nikNameTF) {
            [self.userDic setObject:self.nikNameTF.text forKey:@"username"];
        }else if (textField == self.schoolTF){
            [self.userDic setObject:self.schoolTF.text forKey:@"school"];
        }else if (textField == self.industryTF){
            [self.userDic setObject:self.industryTF.text forKey:@"industry"];
        }
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
