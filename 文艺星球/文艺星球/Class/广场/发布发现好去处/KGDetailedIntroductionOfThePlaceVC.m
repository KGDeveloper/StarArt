//
//  KGDetailedIntroductionOfThePlaceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDetailedIntroductionOfThePlaceVC.h"

@interface KGDetailedIntroductionOfThePlaceVC ()<YYTextViewDelegate,KGImageViewDelegate>
/** 介绍 */
@property (nonatomic,strong) YYTextView *introduceTV;
/** 保存选择的照片 */
@property (nonatomic,strong) NSMutableSet *photosArr;
/** 加载选择的照片 */
@property (nonatomic,strong) UIView *photosView;
/** 选择照片按钮 */
@property (nonatomic,strong) UIButton *chooseBtu;
/** 相册 */
@property (nonatomic,strong) PhotosLibraryView *photoAlbm;

@end

@implementation KGDetailedIntroductionOfThePlaceVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"详细介绍";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = NO;
    
    self.photosArr = [[NSMutableSet alloc]init];
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.photosArr.count > 3) {
        if (self.sendDetailedIntroduction) {
            NSArray *tmp = [self.photosArr allObjects];
            self.sendDetailedIntroduction(self.introduceTV.text, tmp);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[KGHUD showMessage:@"描述照片不得少于3张"] hideAnimated:YES afterDelay:1];
    }
}
/** 页面 */
- (void)setUI{
    self.introduceTV = [[YYTextView alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 20, 50)];
    self.introduceTV.placeholderFont = KGFontSHRegular(14);
    self.introduceTV.placeholderTextColor = KGGrayColor;
    self.introduceTV.placeholderText = @"请输入简介内容";
    self.introduceTV.textColor = KGBlackColor;
    self.introduceTV.font = KGFontSHRegular(14);
    self.introduceTV.delegate = self;
    [self.view addSubview:self.introduceTV];
    /** 照片 */
    self.photosView = [[UIView alloc]initWithFrame:CGRectMake(15, self.introduceTV.frame.origin.y + self.introduceTV.frame.size.height + 60, KGScreenWidth - 30, 240)];
    [self.view addSubview:self.photosView];
    /** 选择照片按钮 */
    self.chooseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtu.frame = CGRectMake(0,0, 75, 75);
    [self.chooseBtu setImage:[UIImage imageNamed:@"tianjiazhaopian"] forState:UIControlStateNormal];
    self.chooseBtu.layer.cornerRadius = 5;
    self.chooseBtu.layer.masksToBounds = YES;
    [self.chooseBtu addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photosView addSubview:self.chooseBtu];
}
/** 代理 */
- (void)textViewDidChange:(YYTextView *)textView{
    if ([self.introduceTV.text boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(14)} context:nil].size.height < KGScreenHeight/2) {
        self.introduceTV.frame = CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 30, [self.introduceTV.text boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(14)} context:nil].size.height);
        self.photosView.frame = CGRectMake(15, self.introduceTV.frame.origin.y + self.introduceTV.frame.size.height + 60, KGScreenWidth - 30, 240);
    }
}
- (void)textViewDidEndEditing:(YYTextView *)textView{
    if (self.introduceTV.text.length > 0) {
        [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = YES;
    }else{
        [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
        self.rightNavItem.userInteractionEnabled = NO;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.introduceTV resignFirstResponder];
}
/** 选择按钮点击事件 */
- (void)chooseAction:(UIButton *)sender{
    self.photoAlbm.hidden = NO;
}
/** 相册 */
- (PhotosLibraryView *)photoAlbm{
    if (!_photoAlbm) {
        _photoAlbm = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        _photoAlbm.maxCount = 9 - self.photosArr.count;
        __weak typeof(self) weakSelf = self;
        _photoAlbm.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            [weakSelf.photosArr addObjectsFromArray:imageArr];
            [weakSelf setImageView];
        };
        [self.navigationController.view addSubview:_photoAlbm];
    }
    return _photoAlbm;
}
/** 创建图片 */
- (void)setImageView{
    for (id obj in self.photosView.subviews) {
        if ([obj isKindOfClass:[KGImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    CGFloat width = 0;
    CGFloat height = 0;
    NSArray *tmpArr = [self.photosArr allObjects];
    for (int i = 0; i < self.photosArr.count; i++) {
        KGImageView *imageView = [[KGImageView alloc]initWithFrame:CGRectMake(width, height, 75, 75)];
        imageView.allowZoom = NO;
        imageView.allowDelete = YES;
        imageView.delegate = self;
        imageView.image = tmpArr[i];
        __weak typeof(self) weakSelf = self;
        imageView.selectDeleteBtuDeleteUIImage = ^(UIImage *deleteImage) {
            [weakSelf.photosArr removeObject:deleteImage];
            [weakSelf setImageView];
        };
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [self.photosView addSubview:imageView];
        if ((i+1)%3==0) {
            width = 0;
            height += 80;
        }else{
            width += 80;
        }
    }
    if (self.photosArr.count < 9) {
        self.chooseBtu.frame = CGRectMake(width, height, 75, 75);
        self.chooseBtu.hidden = NO;
    }else{
        self.chooseBtu.hidden = YES;
    }
}
- (DeleteImageWithState)deleteUIImage{
    return DeleteImageWithStateView;
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
