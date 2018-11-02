//
//  KGPreviewHorizontalTextView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGPreviewHorizontalTextView : UIView
/** 消息文本 */
@property (nonatomic,copy) NSString *contentStr;
/** 选择图片 */
@property (nonatomic,copy) NSArray *photosArr;
/** 文本对齐方式 */
@property (nonatomic,assign) NSTextAlignment labAligment;

@end

NS_ASSUME_NONNULL_END
