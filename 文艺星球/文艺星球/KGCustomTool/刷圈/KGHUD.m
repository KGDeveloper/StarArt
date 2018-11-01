//
//  KGHUD.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGHUD.h"

@implementation KGHUD

/** 显示菊花带文字 */
+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}
/** 显示菊花带文字 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = message;
    hub.contentColor = KGWhiteColor;
    hub.mode = MBProgressHUDModeText;
    hub.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hub.bezelView.color = KGBlackColor;
    hub.removeFromSuperViewOnHide = YES;
    return hub;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
