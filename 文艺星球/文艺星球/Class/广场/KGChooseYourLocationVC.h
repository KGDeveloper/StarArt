//
//  KGChooseYourLocationVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGChooseYourLocationVC : KGBaseViewController
/** 传送选择地址 */
@property (nonatomic,copy) void(^sendLocation)(NSString *name);

@end

NS_ASSUME_NONNULL_END
