//
//  KGTheNameOfThePlaceVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGTheNameOfThePlaceVC : KGBaseViewController
/** 填写信息 */
@property (nonatomic,copy) void(^sendPlaceName)(NSString *chinaName,NSString *englishName);

@end

NS_ASSUME_NONNULL_END
