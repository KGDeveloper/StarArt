//
//  KGEditPhotoView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 图片裁剪类型 */
typedef NS_ENUM(NSInteger,ClipUIImageWithType){
    /** 圆形裁剪 */
    ClipUIImageWithRound = 0,
    /** 竖直方向矩形裁剪 */
    ClipUIImageWithVerticalRectangular,
    /** 水平方向矩形裁剪 */
    ClipUIImageWithHorizontalRectangular,
};
/** 编辑图片 */
@interface KGEditPhotoView : UIView
/** 需要裁剪的UIImage */
@property (nonatomic,strong) UIImage *image;
/** 根据裁剪类型，设置裁剪框 */
- (instancetype)initWithFrame:(CGRect)frame cilpType:(ClipUIImageWithType)clipType;

@end


