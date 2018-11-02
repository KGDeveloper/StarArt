//
//  KGImageView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/11.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGImageView.h"
#import <Photos/Photos.h>
#import "KGHUD.h"

@interface KGImageView ()
/** 展示图片 */
@property (nonatomic,strong) UIImageView *backImageView;
/** 是否开始缩放 */
@property (nonatomic,assign) BOOL isZoom;
/** 初始位置 */
@property (nonatomic,assign) CGRect defoultFrame;
/** 用来弹出提示框 */
@property (nonatomic,strong) UIViewController *alertVC;

@end

@implementation KGImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.allowDelete = NO;
        self.allowZoom = NO;
        self.isZoom = NO;
        self.defoultFrame = frame;
        self.alertVC = [[UIViewController alloc]init];
        [self showImage];
    }
    return self;
}
// MARK: --创建UIImageView 删除按钮--
- (void)showImage{
    self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.backImageView.userInteractionEnabled = YES;
    [self addSubview:self.backImageView];
    /** 添加删除按钮 */
    self.deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtu.frame = CGRectMake(KGViewWidth(self) - 12, 0, 12, 12);
    [self.deleteBtu addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtu.layer.cornerRadius = 6;
    self.deleteBtu.layer.masksToBounds = YES;
    self.deleteBtu.backgroundColor = KGWhiteColor;
    [self addSubview:self.deleteBtu];
    /** 添加轻点手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [self.backImageView addGestureRecognizer:tap];
    /** 添加长按手势 */
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImageToPhotoAlbum:)];
    [self.backImageView addGestureRecognizer:longPress];
    
}
// MARK: --轻点手势--
- (void)selectImage:(UITapGestureRecognizer *)tap{
    /** 判断是否是默认Image，如果是默认那就点击后选择照片，反之放大查看照片 */
    if ([self.backImageView.image isEqual:self.placeholderImage]) {
        if (self.choosePhotoFromPhotoAlbum) {
            self.choosePhotoFromPhotoAlbum();
        }
    }else{
        /** 如果允许图片放大查看，点击放大缩小，反之只是点击选择照片 */
        if (self.allowZoom == YES) {
            /** 判断是否已经放大，如果没有点击的时候放大图片查看，如果已经放大，点击的时候恢复初始值 */
            if (self.isZoom == NO) {
                /** 做一个过渡动画，增加用户体验度 */
                [UIView animateWithDuration:0.7 animations:^{
                    UIView *back = [self supViewController].view;
                    CGSize size = [UIScreen mainScreen].bounds.size;
                    self.frame = CGRectMake(back.frame.origin.x, back.frame.origin.y, size.width, size.height);
                    self.backImageView.frame = CGRectMake(0, 0, size.width, size.width/self.image.size.width*self.image.size.height);
                    self.backImageView.center = self.center;
                }completion:^(BOOL finished) {
                    /** 在完成放大修改背景色，增加用户体验度 */
                    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
                    self.isZoom = YES;
                }];
            }else{
                [UIView animateWithDuration:0.7 animations:^{
                    self.frame = self.defoultFrame;
                    self.backImageView.frame = self.bounds;
                }completion:^(BOOL finished) {
                    self.backgroundColor = [UIColor whiteColor];
                    self.isZoom = NO;
                }];
            }
            
        }else{
            if (self.choosePhotoFromPhotoAlbum) {
                self.choosePhotoFromPhotoAlbum();
            }
        }
    }
}
// MARK: --长按保存图片到相册--
- (void)saveImageToPhotoAlbum:(UILongPressGestureRecognizer *)longPress{
    [self alertView];
}
// MARK: --删除按钮点击事件--
- (void)deleteAction{
    if (self.allowDelete == YES) {
        switch ([self.delegate deleteUIImage]) {
            case DeleteImageWithStateOnlyImage:
                //:--在这里改变 self.backImageView 的图片为初始图片--
                if (self.selectDeleteBtuDeleteUIImage) {
                    self.selectDeleteBtuDeleteUIImage(self.image);
                }
                self.backImageView.image = self.placeholderImage;
                break;
            case DeleteImageWithStateView:
                if (self.selectDeleteBtuDeleteUIImage) {
                    self.selectDeleteBtuDeleteUIImage(self.image);
                }
                [self removeFromSuperview];
                break;
            default:
                break;
        }
    }
}
// MARK: --设置预留图片--
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
    self.backImageView.image = placeholderImage;
}
// MARK: --UIImageView的图片--
- (void)setImage:(UIImage *)image{
    _image = image;
    self.backImageView.image = image;
}
// MARK: --删除按钮的图片--
- (void)setDeleteImage:(UIImage *)deleteImage{
    _deleteImage = deleteImage;
    [self.deleteBtu setImage:deleteImage forState:UIControlStateNormal];
}
// MARK: --提示框--
- (void)alertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *shureAction = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /** 保存到相册 */
        [self savePhotoToPhotoLibary];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:shureAction];
    [alert addAction:cancelAction];
    /** 因为UIAlertController是继承于UIViewController所以UIView无法直接展示，只能通过间接方式 */
    [self addSubview:self.alertVC.view];
    [self.alertVC presentViewController:alert animated:YES completion:nil];
}
// MARK: --保存到相册--
- (void)savePhotoToPhotoLibary{
    /** 注意这里的操作必须在主线程，否则程序会奔溃的 */
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [KGHUD showMessage:@"正在保存..." toView:self];
        __block NSString *assetId = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:self.image].placeholderForCreatedAsset.localIdentifier;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            /** 注意这里的操作必须在主线程，否则程序会奔溃的 */
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                [[KGHUD showMessage:@"保存成功" toView:self] hideAnimated:YES afterDelay:1];
                [self.alertVC.view removeFromSuperview];
            });
        }];
    });
}
// MARK: --获取控制器--
- (UIViewController *)supViewController{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

@end
