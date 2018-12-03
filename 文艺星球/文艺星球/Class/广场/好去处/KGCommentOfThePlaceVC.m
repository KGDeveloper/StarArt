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
@property (nonatomic,assign) NSInteger scroe;
@property (nonatomic,strong) MBProgressHUD *hud;

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
    self.submitBtu.userInteractionEnabled = NO;
    
    self.ideaTV.delegate = self;
    self.scroe = 0;
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
    self.scroe = 1;
}
- (IBAction)twoAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroe = 2;
}
- (IBAction)threeAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroe = 3;
}
- (IBAction)fourAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fiveBtu setImage:[UIImage imageNamed:@"xingxing"] forState:UIControlStateNormal];
    self.scroe = 4;
}
- (IBAction)fiveAction:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.twoBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.threeBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.fourBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    [self.oneBtu setImage:[UIImage imageNamed:@"xing"] forState:UIControlStateNormal];
    self.scroe = 5;
}
- (IBAction)submitAction:(UIButton *)sender {
    if (self.ideaTV.text.length > 0 || ![self.ideaTV.text isEqualToString:@"分享你对这里的评价和感受吧！（至少15个字）"]) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_queue_t queue = dispatch_queue_create("上传图片", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            if (self.imageSet.count > 0) {
                NSArray *tmp = [self.imageSet allObjects];
                __block NSMutableArray *finishArr = [NSMutableArray array];
                __weak typeof(self) weakSelf = self;
                for (int i = 0; i < tmp.count; i++) {
                    [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:tmp[i]] result:^(NSString * _Nonnull strPath) {
                        [finishArr addObject:strPath];
                        [weakSelf requestDataWith:finishArr.copy];
                    }];
                }
            }else{
                [self requestDataWith:@[]];
            }
        });
    }
}
/** 开始请求 */
- (void)requestDataWith:(NSArray *)arr{
    if (arr.count == self.imageSet.count) {
        __weak typeof(self) weakSelf = self;
        [KGRequest postWithUrl:SaveGoodPlaceComment parameters:@{@"uid":[KGUserInfo shareInstance].userId,@"pid":self.detailId,@"comment":self.ideaTV.text,@"score":@(self.scroe),@"images":arr} succ:^(id  _Nonnull result) {
            [weakSelf.hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"评论成功"] hideAnimated:YES afterDelay:1];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [weakSelf.hud hideAnimated:YES];
            [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
        }];
    }
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
        self.submitBtu.backgroundColor = KGLineColor;
        self.submitBtu.userInteractionEnabled = NO;
    }else{
        self.submitBtu.backgroundColor = KGBlueColor;
        self.submitBtu.userInteractionEnabled = YES;
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
