//
//  KGDetailedIntroductionOfThePlaceVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGDetailedIntroductionOfThePlaceVC : KGBaseViewController
/** 详细介绍 */
@property (nonatomic,copy) void(^sendDetailedIntroduction)(NSString *introduce,NSArray<UIImage *> *photos);

@end

NS_ASSUME_NONNULL_END
