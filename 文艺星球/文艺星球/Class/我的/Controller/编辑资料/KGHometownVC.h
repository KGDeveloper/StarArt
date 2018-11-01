//
//  KGHometownVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGHometownVC : KGBaseViewController
/** 已选择的家乡地址 */
@property (nonatomic,copy) void(^sendHomeTownToController)(NSString *homeTown);

@end

NS_ASSUME_NONNULL_END
