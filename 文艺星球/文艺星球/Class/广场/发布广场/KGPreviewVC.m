//
//  KGPreviewVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGPreviewVC.h"
#import "KGPreviewHorizontalTextView.h"
#import "KGPreviewKGPreviewRoundView.h"
#import "KGPreviewVerticalView.h"

@interface KGPreviewVC ()
/** 模板 */
@property (nonatomic,strong) UIScrollView *scrollView;
/** 放大模板 */
@property (nonatomic,assign) NSInteger scaleIndex;
/** 横向排版 */
@property (nonatomic,strong) KGPreviewHorizontalTextView *previewHorizontalView;
/** 圆图排版 */
@property (nonatomic,strong) KGPreviewKGPreviewRoundView *previewRoundView;
/** 竖直排版 */
@property (nonatomic,strong) KGPreviewVerticalView *previewVerticalView;
/** 发布信息 */
@property (nonatomic,strong) NSMutableDictionary *userDic;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) NSMutableSet *imgs;

@end

@implementation KGPreviewVC

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
    [self setRightNavItemWithFrame:CGRectZero title:@"发布" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"位置";
    self.view.backgroundColor = KGWhiteColor;
    self.scaleIndex = 0;
    self.userDic = [NSMutableDictionary dictionaryWithObject:[KGUserInfo shareInstance].userId forKey:@"uid"];
    [self setUpScrollView];
    
    [self.view bringSubviewToFront:self.previewHorizontalView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    [self.userDic setObject:[KGUserInfo shareInstance].userName forKey:@"userName"];
    [self.userDic setObject:[KGUserInfo shareInstance].userPortrait forKey:@"userPortraitUri"];
    [self.userDic setObject:[NSString stringWithFormat:@"%ld",(long)self.scaleIndex] forKey:@"composing"];
    [self.userDic setObject:self.contentStr forKey:@"content"];
    [self.userDic setObject:self.locationStr forKey:@"location"];
    self.hud = [KGHUD showMessage:@"正在发布..."];
    self.imgs = [NSMutableSet set];
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < self.photosArr.count; i++) {
        dispatch_queue_t queue = dispatch_queue_create("上传图片", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.photosArr[i]] result:^(NSString * _Nonnull strPath) {
                [weakSelf.imgs addObject:@{@"imageUrl":strPath}];
                [weakSelf RequestData];
            }];
        });
    }
}
/** 请求 */
- (void)RequestData{
    __weak typeof(self) weakSelf = self;
    if (self.imgs.count == self.photosArr.count) {
        [self.userDic setObject:[self.imgs allObjects] forKey:@"imgs"];
        [KGRequest postWithUrl:ReleaseFriends parameters:self.userDic succ:^(id  _Nonnull result) {
            [weakSelf.hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"发布成功"] hideAnimated:YES afterDelay:1];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"发布失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [weakSelf.hud hideAnimated:YES];
            [[KGHUD showMessage:@"发布失败"] hideAnimated:YES afterDelay:1];
        }];
    }
}
/** 滚动模板 */
- (void)setUpScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 150, KGScreenWidth, 150)];
    self.scrollView.contentSize = CGSizeMake(500, 150);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    [self setImageBtu];
    
}
/** 创建模板 */
- (void)setImageBtu{
    CGFloat width = 20;
    NSArray *imageArr = @[[UIImage imageNamed:@"shangzuo"],[UIImage imageNamed:@"shangzhong"],[UIImage imageNamed:@"shangyuan"],[UIImage imageNamed:@"youshang"],[UIImage imageNamed:@"youzhong"]];
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width, self.scrollView.bounds.size.height - 100, 70, 90)];
        imageView.image = imageArr[i];
        imageView.tag = 200 + i;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        width += 90;
        if (i == self.scaleIndex) {
            imageView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImageScale:)];
        [imageView addGestureRecognizer:tap];
    }
}
/** 点击放大 */
- (void)changeImageScale:(UITapGestureRecognizer *)tap{
    self.scaleIndex = tap.view.tag - 200;
    [self.userDic setObject:[NSString stringWithFormat:@"%ld",(long)self.scaleIndex] forKey:@"composing"];
    for (id obj in self.scrollView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = obj;
            imageView.layer.transform = CATransform3DIdentity;
        }
    }
    UIView *imageView = tap.view;
    imageView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
    if (tap.view.tag==200) {
        self.previewRoundView.hidden = YES;
        self.previewHorizontalView.hidden = NO;
        self.previewVerticalView.hidden = YES;
        self.previewHorizontalView.labAligment = NSTextAlignmentLeft;
    }else if (tap.view.tag==201){
        self.previewRoundView.hidden = YES;
        self.previewHorizontalView.hidden = NO;
        self.previewVerticalView.hidden = YES;
        self.previewHorizontalView.labAligment = NSTextAlignmentCenter;
    }else if (tap.view.tag==202){
        self.previewRoundView.hidden = NO;
        self.previewHorizontalView.hidden = YES;
        self.previewVerticalView.hidden = YES;
    }else if (tap.view.tag==203){
        self.previewRoundView.hidden = YES;
        self.previewHorizontalView.hidden = YES;
        self.previewVerticalView.hidden = NO;
        self.previewVerticalView.isCenter = NO;
    }else if (tap.view.tag==204){
        self.previewRoundView.hidden = YES;
        self.previewHorizontalView.hidden = YES;
        self.previewVerticalView.hidden = NO;
        self.previewVerticalView.isCenter = YES;
    }
}
/** 横向排版 */
- (KGPreviewHorizontalTextView *)previewHorizontalView{
    if (!_previewHorizontalView) {
        _previewHorizontalView = [[KGPreviewHorizontalTextView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 25, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 200)];
        _previewHorizontalView.contentStr = self.contentStr;
        _previewHorizontalView.photosArr = self.photosArr;
        [self.view addSubview:_previewHorizontalView];
    }
    return _previewHorizontalView;
}
/** 圆图排版 */
- (KGPreviewKGPreviewRoundView *)previewRoundView{
    if (!_previewRoundView) {
        _previewRoundView = [[KGPreviewKGPreviewRoundView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 25, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 200)];
        _previewRoundView.contentStr = self.contentStr;
        _previewRoundView.photosArr = self.photosArr;
        [self.view addSubview:_previewRoundView];
    }
    return _previewRoundView;
}
/** 竖直排版 */
- (KGPreviewVerticalView *)previewVerticalView{
    if (!_previewVerticalView) {
        _previewVerticalView = [[KGPreviewVerticalView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 25, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 200)];
        _previewVerticalView.contentStr = self.contentStr;
        _previewVerticalView.photosArr = self.photosArr;
        [self.view addSubview:_previewVerticalView];
    }
    return _previewVerticalView;
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
