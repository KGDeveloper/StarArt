//
//  KGPlaceTheCoverVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGPlaceTheCoverVC.h"

@interface KGPlaceTheCoverVC ()
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *shureBtu;
/** 封面 */
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
/** 相册 */
@property (nonatomic,strong) PhotosLibraryView *photoAlbm;

@end

@implementation KGPlaceTheCoverVC

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
    /** 导航栏标题 */
    self.title = @"地点封面";
    self.view.backgroundColor = KGWhiteColor;
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 点击确定 */
- (IBAction)shureAction:(UIButton *)sender {
    if (self.sendPlaceTheCover) {
        self.sendPlaceTheCover(self.coverImage.image);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 点击选择 */
- (IBAction)chooseAction:(UIButton *)sender {
    self.photoAlbm.hidden = NO;
}
/** 相册 */
- (PhotosLibraryView *)photoAlbm{
    if (!_photoAlbm) {
        _photoAlbm = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        _photoAlbm.maxCount = 1;
        __weak typeof(self) weakSelf = self;
        _photoAlbm.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            weakSelf.coverImage.image = [imageArr firstObject];
            weakSelf.shureBtu.userInteractionEnabled = YES;
            weakSelf.shureBtu.backgroundColor = KGBlueColor;
        };
        [self.navigationController.view addSubview:_photoAlbm];
    }
    return _photoAlbm;
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
