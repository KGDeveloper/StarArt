//
//  KGCommentOfThePlaceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGCommentOfThePlaceVC.h"

@interface KGCommentOfThePlaceVC ()<UITextViewDelegate,KGImageViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *oneBtu;
@property (weak, nonatomic) IBOutlet UIButton *twoBtu;
@property (weak, nonatomic) IBOutlet UIButton *threeBtu;
@property (weak, nonatomic) IBOutlet UIButton *fourBtu;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtu;
@property (weak, nonatomic) IBOutlet UITextView *ideaTV;
@property (weak, nonatomic) IBOutlet UIView *photosView;
@property (weak, nonatomic) IBOutlet UIButton *addImageBtu;
@property (weak, nonatomic) IBOutlet UIButton *submitBtu;
/** 相册 */
@property (nonatomic,strong) PhotosLibraryView *photoAlbm;
/** 保存选择的照片 */
@property (nonatomic,strong) NSMutableSet *imageSet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addBtuLeft;

@end

@implementation KGCommentOfThePlaceVC

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
    self.title = @"评论好去处";
    self.view.backgroundColor = KGWhiteColor;
    
    self.ideaTV.delegate = self;
    self.imageSet = [[NSMutableSet alloc]init];
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)oneAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
}
- (IBAction)twoAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
}
- (IBAction)threeAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
}
- (IBAction)fourAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
}
- (IBAction)fiveAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
}
- (IBAction)submitAction:(UIButton *)sender {
    
}
- (IBAction)addImageAction:(UIButton *)sender {
    self.photoAlbm.hidden = NO;
}
/** 相册 */
- (PhotosLibraryView *)photoAlbm{
    if (!_photoAlbm) {
        _photoAlbm = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        _photoAlbm.maxCount = 3 - self.imageSet.count;
        __weak typeof(self) weakSelf = self;
        _photoAlbm.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            [weakSelf.imageSet addObjectsFromArray:imageArr];
            [weakSelf changePhotosView];
        };
        [self.navigationController.view addSubview:_photoAlbm];
    }
    return _photoAlbm;
}
/** 展示图片 */
- (void)changePhotosView{
    for (id obj in self.photosView.subviews) {
        if ([obj isKindOfClass:[KGImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    if (self.imageSet.count > 0) {
        NSArray *imageArr = [self.imageSet allObjects];
        for (int i = 0; i < self.imageSet.count; i++) {
            KGImageView *imageView = [[KGImageView alloc]initWithFrame:CGRectMake(80*i, 0, 75, 75)];
            imageView.allowDelete = YES;
            imageView.delegate = self;
            __weak typeof(self) weakSelf = self;
            imageView.selectDeleteBtuDeleteUIImage = ^(UIImage *deleteImage) {
                [weakSelf.imageSet removeObject:deleteImage];
                [weakSelf changePhotosView];
            };
            imageView.layer.cornerRadius = 5;
            imageView.layer.masksToBounds = YES;
            imageView.image = imageArr[i];
            [self.photosView addSubview:imageView];
        }
        if (self.imageSet.count < 3) {
            self.addImageBtu.hidden = NO;
            self.addBtuLeft.constant = 80*self.imageSet.count;
        }else{
            self.addImageBtu.hidden = YES;
        }
    }else{
        self.addImageBtu.hidden = NO;
        self.addBtuLeft.constant = 0;
    }
}
/** 设置删除模式 */
- (DeleteImageWithState)deleteUIImage{
    return DeleteImageWithStateView;
}
/** 监听输入 */
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.ideaTV.text isEqualToString:@"分享你对这里的评价和感受吧！（至少15个字）"]) {
        self.ideaTV.textColor = KGBlackColor;
        self.ideaTV.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.ideaTV.text.length < 1) {
        self.ideaTV.textColor = KGGrayColor;
        self.ideaTV.text = @"分享你对这里的评价和感受吧！（至少15个字）";
    }
}
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
