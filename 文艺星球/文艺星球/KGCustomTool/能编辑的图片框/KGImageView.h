//
//  KGImageView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/11.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DeleteImageWithState){
    /** 删除UIImage */
    DeleteImageWithStateOnlyImage = 0,
    /** 删除加载UIImage的UIView */
    DeleteImageWithStateView,
};

@protocol KGImageViewDelegate <NSObject>

/** 如果显示删除按钮，根据状态删除UIImage或者UIView */
- (DeleteImageWithState)deleteUIImage;

@end

@interface KGImageView : UIView
/** 想要展示的Image 注：默认图片不能和展示图片相同 */
@property (nonatomic,strong) UIImage *image;
/** 默认展示Image 注：默认图片不能和展示图片相同 */
@property (nonatomic,strong) UIImage *placeholderImage;
/** 删除按钮的图片 */
@property (nonatomic,strong) UIImage *deleteImage;
/** 是否允许删除,默认是NO */
@property (nonatomic,assign) BOOL allowDelete;
/** 是否允许缩放,默认是NO */
@property (nonatomic,assign) BOOL allowZoom;
/** 删除图片 */
@property (nonatomic,copy) void(^selectDeleteBtuDeleteUIImage)(UIImage *deleteImage);
/** 点击添加或者选择照片 */
@property (nonatomic,copy) void(^choosePhotoFromPhotoAlbum)(void);
/** 代理方法 */
@property (nonatomic,weak) id<KGImageViewDelegate>delegate;

@end

