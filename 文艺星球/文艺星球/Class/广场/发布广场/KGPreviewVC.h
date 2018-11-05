//
//  KGPreviewVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGPreviewVC : KGBaseViewController
/** 消息内容 */
@property (nonatomic,copy) NSString *contentStr;
/** 选择的图片 */
@property (nonatomic,copy) NSArray *photosArr;

@end

NS_ASSUME_NONNULL_END
