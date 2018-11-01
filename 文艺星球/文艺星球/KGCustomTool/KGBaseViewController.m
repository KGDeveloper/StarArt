//
//  KGBaseViewController.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/9/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"


@interface KGBaseViewController ()

@end

@implementation KGBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
/** 隐藏底部导航栏 */
- (void)pushHideenTabbarViewController:(UIViewController *)kidsViewController animted:(BOOL)animated{
    kidsViewController.hidesBottomBarWhenPushed = YES;
    UIImage *image = [UIImage new];
    [self.navigationController.navigationBar setShadowImage:image];
    [self.navigationController pushViewController:kidsViewController animated:animated];
}
/** 显示底部导航栏 */
- (void)showTabbar{
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setShadowImage:nil];
}
/** 设置左侧导航栏 */
- (UIButton *)leftNavItem{
    if (!_leftNavItem) {
        _leftNavItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:_leftNavItem]];
    }
    return _leftNavItem;
}
/** 设置右侧导航栏 */
- (UIButton *)rightNavItem{
    if (!_rightNavItem) {
        _rightNavItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:_rightNavItem]];
    }
    return _rightNavItem;
}
/** 设置导航栏左侧按钮 */
- (void)setLeftNavItemWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image font:(UIFont *)font color:(UIColor *)color select:(SEL)select{
    /** 判断frame是否为空 */
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.leftNavItem.frame = CGRectMake(15, 0, 70, 30);
    }else{
        self.leftNavItem.frame = frame;
    }
    /** 判断图片是否为空 */
    if (image != nil) {
        /** 判断标题是否为空 */
        if (title.length != 0) {
            [self.leftNavItem setTitle:title forState:UIControlStateNormal];
            [self.leftNavItem setImage:image forState:UIControlStateNormal];
            [self.leftNavItem setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
        }else{
            [self.leftNavItem setImage:image forState:UIControlStateNormal];
        }
    }else{
        /** 判断标题是否为空 */
        if (title.length != 0) {
            [self.leftNavItem setTitle:title forState:UIControlStateNormal];
        }
    }
    /** 判断字体大小 */
    if (font != nil) {
        self.leftNavItem.titleLabel.font = font;
    }else{
        self.leftNavItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    /** 判断颜色 */
    if (color != nil) {
        [self.leftNavItem setTitleColor:color forState:UIControlStateNormal];
    }else{
        [self.leftNavItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    self.leftNavItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    /** 添加点击事件 */
    [self.leftNavItem addTarget:self action:select forControlEvents:UIControlEventTouchUpInside];
}
/** 导航栏右侧按钮 */
- (void)setRightNavItemWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image font:(UIFont *)font color:(UIColor *)color select:(SEL)select{
    /** 判断frame是否为空 */
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.rightNavItem.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 70, 30);
    }else{
        self.rightNavItem.frame = frame;
    }
    /** 判断图片是否为空 */
    if (image != nil) {
        /** 判断标题是否为空 */
        if (title.length != 0) {
            [self.rightNavItem setTitle:title forState:UIControlStateNormal];
            [self.rightNavItem setImage:image forState:UIControlStateNormal];
            [self.rightNavItem setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
        }else{
            [self.rightNavItem setImage:image forState:UIControlStateNormal];
        }
    }else{
        /** 判断标题是否为空 */
        if (title.length != 0) {
            [self.rightNavItem setTitle:title forState:UIControlStateNormal];
        }
    }
    /** 判断字体大小 */
    if (font != nil) {
        self.rightNavItem.titleLabel.font = font;
    }else{
        self.rightNavItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    /** 判断颜色 */
    if (color != nil) {
        [self.rightNavItem setTitleColor:color forState:UIControlStateNormal];
    }else{
        [self.rightNavItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    self.rightNavItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    /** 添加点击事件 */
    [self.rightNavItem addTarget:self action:select forControlEvents:UIControlEventTouchUpInside];
}
/** 根据日期判断星座 */
- (NSString *)determineTheconstellationWithMonth:(NSInteger)month day:(NSInteger)day{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (month<1||month>12||day<1||day>31){
        return @"错误日期格式!";
    }
    if(month==2 && day>29){
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    result = [NSString stringWithFormat:@"%@座",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}
/** 计算字符串长度 */
- (CGFloat)calculateWidthWithString:(NSString *)string font:(UIFont *)font{
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize statueSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    return statueSize.width;
}
/** 修改导航栏颜色 */
- (void)changeNavBackColor:(UIColor *)color controller:(UIViewController *)controller{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [controller.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}
/** 设置导航栏标题颜色字体 */
- (void)changeNavTitleColor:(UIColor *)color font:(UIFont *)font controller:(UIViewController *)controller{
    [controller.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
