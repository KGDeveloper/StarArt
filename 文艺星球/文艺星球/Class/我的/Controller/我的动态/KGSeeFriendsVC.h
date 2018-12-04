//
//  KGSeeFriendsVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGSeeFriendsVC : KGBaseViewController
/** 是否显示关注按钮 */
@property (nonatomic,copy) NSString *isShow;
/** 是否关注 */
@property (nonatomic,copy) NSString *isAttention;

@end

NS_ASSUME_NONNULL_END
