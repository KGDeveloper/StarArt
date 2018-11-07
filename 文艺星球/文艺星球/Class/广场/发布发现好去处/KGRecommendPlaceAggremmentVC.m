//
//  KGRecommendPlaceAggremmentVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGRecommendPlaceAggremmentVC.h"

@interface KGRecommendPlaceAggremmentVC ()

@end

@implementation KGRecommendPlaceAggremmentVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"推荐店铺用户协议说明";
    self.view.backgroundColor = KGWhiteColor;
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** ui */
- (void)setUI{
    NSAttributedString *attStr = @"提交，即表示您能够保证您提交的地点描述文字、图片为您本人原创，文艺星球拥有了相关使用产权，如发生纠纷皆与文艺星球无关。";
    UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 20, KGScreenWidth - 30, [attStr boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height)];
    topLab.textColor = KGBlackColor;
    topLab.attributedText = attStr;
    topLab.font = KGFontSHRegular(14);
    [self.view addSubview:topLab];
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
