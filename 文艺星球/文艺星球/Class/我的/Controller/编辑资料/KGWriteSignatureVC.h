//
//  KGWriteSignatureVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KGWriteSignatureVC : KGBaseViewController
/** block传值个性签名 */
@property (nonatomic,copy) void(^sendSignature)(NSString *signature);

@end

NS_ASSUME_NONNULL_END
