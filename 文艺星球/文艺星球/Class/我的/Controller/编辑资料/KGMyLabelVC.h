//
//  KGMyLabelVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGMyLabelVC : KGBaseViewController

/** 已选择的标签 */
@property (nonatomic,copy) void(^sendChooseLabel)(NSArray *chooseArr);

@end

NS_ASSUME_NONNULL_END
