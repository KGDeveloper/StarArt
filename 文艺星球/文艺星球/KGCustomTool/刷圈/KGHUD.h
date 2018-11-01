//
//  KGHUD.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MBProgressHUD.h"

@interface KGHUD : MBProgressHUD
/** 显示菊花 */
+ (MBProgressHUD *)showMessage:(NSString *)message;
/** 显示菊花 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

@end
