//
//  KGReleaseVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGReleaseVC.h"
#import "KGChooseYourLocationVC.h"
#import "KGPreviewVC.h"

@interface KGReleaseVC ()<YYTextViewDelegate,KGImageViewDelegate>
/** 想法 */
@property (nonatomic,strong) YYTextView *ideaTV;
/** 选择图片按钮 */
@property (nonatomic,strong) UIButton *chooseBtu;
/** 选择地点 */
@property (nonatomic,strong) UIButton *locationBtu;
/** 相册 */
@property (nonatomic,strong) PhotosLibraryView *photoAlbm;
/** 选择的照片数组 */
@property (nonatomic,strong) NSMutableArray *photosArr;
/** 提示 */
@property (nonatomic,strong) UIView *alertView;

@end

@implementation KGReleaseVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHRegular(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"预览" image:nil font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"编辑资料";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = YES;
    
    /** 初始化 */
    _photosArr = [NSMutableArray array];
    
    [self setUpIdeaView];
    [self setUpChoosePhotosView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    KGPreviewVC *vc = [[KGPreviewVC alloc]init];
    vc.contentStr = self.ideaTV.text;
    vc.photosArr = self.photosArr.copy;
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 想法 */
- (void)setUpIdeaView{
    self.ideaTV = [[YYTextView alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 30, 120)];
    self.ideaTV.placeholderText = @"这一刻的想法...";
    self.ideaTV.placeholderFont = KGFontFZ(13);
    self.ideaTV.placeholderTextColor = KGGrayColor;
    self.ideaTV.textColor = KGBlackColor;
    self.ideaTV.font = KGFontFZ(13);
    [self.view addSubview:self.ideaTV];
}
/** 选择照片 */
- (void)setUpChoosePhotosView{
    
    /** 选择照片按钮 */
    self.chooseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtu.frame = CGRectMake(15,KGRectNavAndStatusHight + 160, 75, 75);
    [self.chooseBtu setImage:[UIImage imageNamed:@"tianjiazhaopian"] forState:UIControlStateNormal];
    self.chooseBtu.layer.cornerRadius = 5;
    self.chooseBtu.layer.masksToBounds = YES;
    [self.chooseBtu addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseBtu];
    /** 选择地点 */
    self.locationBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationBtu.frame = CGRectMake(15,KGRectNavAndStatusHight + 260, KGScreenWidth - 30, 35);
    [self.locationBtu setImage:[UIImage imageNamed:@"shouyedingwei"] forState:UIControlStateNormal];
    [self.locationBtu setTitle:@"你在哪里？" forState:UIControlStateNormal];
    [self.locationBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    self.locationBtu.titleLabel.font = KGFontSHRegular(12);
    self.locationBtu.titleEdgeInsets = UIEdgeInsetsMake(0, self.locationBtu.imageView.bounds.size.width + 10, 0, 0);
    self.locationBtu.layer.cornerRadius = 5;
    self.locationBtu.layer.masksToBounds = YES;
    self.locationBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.locationBtu addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.locationBtu];
    /** 提示信息 */
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 320, KGScreenWidth - 30, 60)];
    [self.view addSubview:self.alertView];
    UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth - 30, 15)];
    alertLab.text = @"提示";
    alertLab.textColor = KGGrayColor;
    alertLab.font = KGFontSHRegular(15);
    [self.alertView addSubview:alertLab];
    UILabel *alertOne = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, KGScreenWidth - 30, 12)];
    alertOne.text = @"每行最多20字，总字数不能超过100字。（包括标点符号）";
    alertOne.textColor = KGGrayColor;
    alertOne.font = KGFontSHRegular(12);
    [self.alertView addSubview:alertOne];
    UILabel *alertTwo = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, KGScreenWidth - 30, 12)];
    alertTwo.text = @"行与行之间用回车或者用“。”或“！”来隔开。（中文字符）";
    alertTwo.textColor = KGGrayColor;
    alertTwo.font = KGFontSHRegular(12);
    [self.alertView addSubview:alertTwo];
}
/** 选择按钮点击事件 */
- (void)chooseAction:(UIButton *)sender{
    self.photoAlbm.hidden = NO;
}
/** 选择位置点击事件 */
- (void)locationAction:(UIButton *)sender{
    KGChooseYourLocationVC *vc = [[KGChooseYourLocationVC alloc]init];
    __weak typeof(self) weakSelf = self;
    vc.sendLocation = ^(NSString * _Nonnull name) {
        [weakSelf.locationBtu setTitle:name forState:UIControlStateNormal];
        [weakSelf.locationBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    };
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 相册 */
- (PhotosLibraryView *)photoAlbm{
    if (!_photoAlbm) {
        _photoAlbm = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        _photoAlbm.maxCount = 9 - self.photosArr.count;
        __weak typeof(self) weakSelf = self;
        _photoAlbm.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            [weakSelf.photosArr addObjectsFromArray:imageArr];
            [weakSelf changePhotosViewSubViews];
        };
        [self.navigationController.view addSubview:_photoAlbm];
    }
    return _photoAlbm;
}
/** 创建选择相册 */
- (void)changePhotosViewSubViews{
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[KGImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    CGFloat width = 15;
    CGFloat height = KGRectNavAndStatusHight + 160;
    for (int i = 0; i < self.photosArr.count; i++) {
        KGImageView *imageView = [[KGImageView alloc]initWithFrame:CGRectMake(width,height, 75, 75)];
        imageView.allowZoom = NO;
        imageView.allowDelete = YES;
        imageView.delegate = self;
        imageView.image = self.photosArr[i];
        __weak typeof(self) weakSelf = self;
        imageView.selectDeleteBtuDeleteUIImage = ^(UIImage *deleteImage) {
            [weakSelf.photosArr removeObject:deleteImage];
            [weakSelf changePhotosViewSubViews];
        };
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [self.view addSubview:imageView];
        if ((i+1)%3==0) {
            width = 15;
            height += 90;
        }else{
            width += 90;
        }
    }
    if (self.photosArr.count < 9) {
        self.chooseBtu.frame = CGRectMake(width, height, 75, 75);
        self.chooseBtu.hidden = NO;
        self.locationBtu.frame = CGRectMake(15,height + 100, KGScreenWidth - 30, 75);
    }else{
        self.chooseBtu.hidden = YES;
        self.locationBtu.frame = CGRectMake(15,height + 25, KGScreenWidth - 30, 75);
    }
    self.alertView.frame = CGRectMake(15, self.locationBtu.frame.origin.y + 60, KGScreenWidth - 30, 60);
}
/** KGImageViewDelegate */
- (DeleteImageWithState)deleteUIImage{
    return DeleteImageWithStateView;
}
/** 监听键盘 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.ideaTV resignFirstResponder];
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
