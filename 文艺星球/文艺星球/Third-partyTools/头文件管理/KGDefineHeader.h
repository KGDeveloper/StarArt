//
//  KGDefineHeader.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef KGDefineHeader_h
#define KGDefineHeader_h

/** 获取view的宽 */
#define KGViewWidth(view) view.bounds.size.width
/** 获取view的高 */
#define KGViewHeight(view) view.bounds.size.height
/** 获取view的x坐标点 */
#define KGViewX(view) view.frame.origin.x
/** 获取view的y坐标点 */
#define KGViewY(view) view.frame.origin.y
/** 屏幕宽 */
#define KGScreenWidth  [UIScreen mainScreen].bounds.size.width
/** 屏幕高 */
#define KGScreenHeight  [UIScreen mainScreen].bounds.size.height
/** 设置颜色 */
#define KGColor(color) [UIColor colorWithHexString:color]
/** 白色 */
#define KGWhiteColor KGColor(@"#ffffff")
/** 灰色 */
#define KGGrayColor KGColor(@"#999999")
/** 黑色 */
#define KGBlackColor KGColor(@"#333333")
/** 男 */
#define KGManColor KGColor(@"#66c7ff")
/** 女 */
#define KGWomanColor KGColor(@"#ff6666")
/** 线色 */
#define KGLineColor KGColor(@"#ededed")
/** 区域灰色 */
#define KGAreaGrayColor KGColor(@"#f5f5f5")
/** 蓝色 */
#define KGBlueColor KGColor(@"#6699ff")
/** 透明遮罩 */
#define KGAlpheColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
/** 设置思源细体字体 */
#define KGFontSHRegular(font) [UIFont fontWithName:@"SourceHanSansCN-Regular" size:font]
/** 设置思源粗体字体 */
#define KGFontSHBold(font) [UIFont fontWithName:@"SourceHanSansCN-Bold" size:font]
/** 设置方正字体 */
#define KGFontFZ(font) [UIFont fontWithName:@"FZYingXueS-R-GB" size:font]
/** 获取状态栏加导航栏高度 */
//#define KGRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
/** 获取tabbar高度 */
#define KGRectTabbarHeight self.tabBarController.tabBar.bounds.size.height

#endif /* KGDefineHeader_h */
//获取导航栏+状态栏的高度
#define KGRectNavAndStatusHight ({CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];CGRect rectNav = self.navigationController.navigationBar.frame;(rectStatus.size.height+ rectNav.size.height);})
