//
//  KGPreviewVerticalView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGPreviewVerticalView : UIView

/** 消息文本 */
@property (nonatomic,copy) NSString *contentStr;
/** 选择图片 */
@property (nonatomic,copy) NSArray *photosArr;
/** 显示模式 */
@property (nonatomic,assign) BOOL isCenter;

@end

NS_ASSUME_NONNULL_END
