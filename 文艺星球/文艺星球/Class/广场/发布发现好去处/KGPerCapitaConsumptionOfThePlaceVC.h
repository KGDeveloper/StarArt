//
//  KGPerCapitaConsumptionOfThePlaceVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGPerCapitaConsumptionOfThePlaceVC : KGBaseViewController
/** 人均消费 */
@property (nonatomic,copy) void(^sendPriceString)(NSString *price);

@end

NS_ASSUME_NONNULL_END
