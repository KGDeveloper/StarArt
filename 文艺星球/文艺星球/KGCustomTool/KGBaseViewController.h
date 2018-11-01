//
//  KGBaseViewController.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/9/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGBaseViewController;
@interface KGBaseViewController : UIViewController
/** 左侧导航栏按钮 */
@property (nonatomic,strong) UIButton *leftNavItem;
/** 右侧导航栏按钮 */
@property (nonatomic,strong) UIButton *rightNavItem;
/**
 跳转影藏底部导航栏的UIViewController

 @param kidsViewController 将要跳转到的目标ViewController
 @param animated 是否含有动画
 */
- (void)pushHideenTabbarViewController:(UIViewController *)kidsViewController animted:(BOOL)animated;
/** 显示底部导航栏 */
- (void)showTabbar;
/**
 设置导航栏左侧按钮

 @param frame 坐标，大小（可以为空）
 @param title 标题（可以为空）
 @param image 图片（可以为空）
 @param font 字体大小（可以为空）
 @param color 颜色（可以为空）
 @param select 点击事件（不能为空为空）
 */
- (void)setLeftNavItemWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image font:(UIFont *)font color:(UIColor *)color select:(SEL)select;
/**
 设置导航栏右侧按钮
 
 @param frame 坐标，大小（可以为空）
 @param title 标题（可以为空）
 @param image 图片（可以为空）
 @param font 字体大小（可以为空）
 @param color 颜色（可以为空）
 @param select 点击事件（不能为空为空）
 */
- (void)setRightNavItemWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image font:(UIFont *)font color:(UIColor *)color select:(SEL)select;
/**
 根据日期判断星座

 @param month 月份
 @param day 每月的第几天
 @return 星座
 */
- (NSString *)determineTheconstellationWithMonth:(NSInteger)month day:(NSInteger)day;
/**
 根据字符串计算长度

 @param string 字符串
 @param font 字体大小
 @return 长度
 */
- (CGFloat)calculateWidthWithString:(NSString *)string font:(UIFont *)font;
/** 改变导航烂颜色 */
- (void)changeNavBackColor:(UIColor *)color controller:(UIViewController *)controller;
/** 设置导航栏标题颜色字体 */
- (void)changeNavTitleColor:(UIColor *)color font:(UIFont *)font controller:(UIViewController *)controller;

@end

