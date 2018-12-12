//
//  KGScreenNearPersonVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGScreenNearPersonVC.h"

@interface KGScreenNearPersonVC ()
@property (weak, nonatomic) IBOutlet UILabel *qiuxieLab;
@property (weak, nonatomic) IBOutlet UILabel *wenshenLab;
@property (weak, nonatomic) IBOutlet UILabel *jixianLab;
@property (weak, nonatomic) IBOutlet UILabel *sheyingLab;
@property (weak, nonatomic) IBOutlet UILabel *erciyuanLab;
@property (weak, nonatomic) IBOutlet UILabel *dianjingLab;
@property (weak, nonatomic) IBOutlet UILabel *gaizhuangcheLab;
@property (weak, nonatomic) IBOutlet UILabel *shuochangLab;
@property (weak, nonatomic) IBOutlet UILabel *chongwuLab;
@property (weak, nonatomic) IBOutlet UILabel *jianshenLab;
@property (weak, nonatomic) IBOutlet UILabel *bengdiLab;
@property (weak, nonatomic) IBOutlet UILabel *xijuLab;
@property (weak, nonatomic) IBOutlet UILabel *lianaiLab;
@property (weak, nonatomic) IBOutlet UILabel *dianyingLab;
@property (weak, nonatomic) IBOutlet UILabel *lvxingLab;
@property (weak, nonatomic) IBOutlet UILabel *ktvLab;

@end

@implementation KGScreenNearPersonVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"筛选";
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)qiuxieAction:(UIButton *)sender {
    [self changeLabTitleWithString:@"球鞋爱好者"];
}
- (IBAction)wenshenAction:(UIButton *)sender {
    [self changeLabTitleWithString:@"纹身"];
}
- (IBAction)jixianAction:(UIButton *)sender {
    [self changeLabTitleWithString:@"极限运动"];
}
- (IBAction)sheyingAction:(id)sender {
    [self changeLabTitleWithString:@"摄影"];
}
- (IBAction)erciyuanAction:(id)sender {
    [self changeLabTitleWithString:@"二次元"];
}
- (IBAction)dianjingAction:(id)sender {
    [self changeLabTitleWithString:@"电竞"];
}
- (IBAction)gaizhuangcheAction:(id)sender {
    [self changeLabTitleWithString:@"改装车"];
}
- (IBAction)shuochangAction:(id)sender {
    [self changeLabTitleWithString:@"说唱"];
}
- (IBAction)chongwuAction:(id)sender {
    [self changeLabTitleWithString:@"宠物"];
}
- (IBAction)lianaiAction:(id)sender {
    [self changeLabTitleWithString:@"恋爱"];
}
- (IBAction)jianshenAction:(id)sender {
    [self changeLabTitleWithString:@"健身"];
}
- (IBAction)bengdiAction:(id)sender {
    [self changeLabTitleWithString:@"蹦迪"];
}
- (IBAction)lvxingAction:(id)sender {
    [self changeLabTitleWithString:@"旅行"];
}
- (IBAction)xijuAction:(id)sender {
    [self changeLabTitleWithString:@"戏剧"];
}
- (IBAction)ktvAction:(id)sender {
    [self changeLabTitleWithString:@"ktv"];
}
- (IBAction)dianyingAction:(id)sender {
    [self changeLabTitleWithString:@"电影"];
}

/** 修改lab颜色 */
- (void)changeLabTitleWithString:(NSString *)str{
    self.qiuxieLab.textColor = KGBlackColor;
    self.wenshenLab.textColor = KGBlackColor;
    self.jixianLab.textColor = KGBlackColor;
    self.sheyingLab.textColor = KGBlackColor;
    self.erciyuanLab.textColor = KGBlackColor;
    self.dianjingLab.textColor = KGBlackColor;
    self.gaizhuangcheLab.textColor = KGBlackColor;
    self.shuochangLab.textColor = KGBlackColor;
    self.chongwuLab.textColor = KGBlackColor;
    self.jianshenLab.textColor = KGBlackColor;
    self.bengdiLab.textColor = KGBlackColor;
    self.xijuLab.textColor = KGBlackColor;
    self.lianaiLab.textColor = KGBlackColor;
    self.dianyingLab.textColor = KGBlackColor;
    self.lvxingLab.textColor = KGBlackColor;
    self.ktvLab.textColor = KGBlackColor;
    if ([str isEqualToString:@"球鞋爱好者"]) {
        self.qiuxieLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"纹身"]){
        self.wenshenLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"极限运动"]){
        self.jixianLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"摄影"]){
        self.sheyingLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"二次元"]){
        self.erciyuanLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"电竞"]){
        self.dianjingLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"改装车"]){
        self.gaizhuangcheLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"说唱"]){
        self.shuochangLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"宠物"]){
        self.chongwuLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"健身"]){
        self.jianshenLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"蹦迪"]){
        self.bengdiLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"戏剧"]){
        self.xijuLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"恋爱"]){
        self.lianaiLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"电影"]){
        self.dianyingLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"旅行"]){
        self.lvxingLab.textColor = KGBlueColor;
    }else if ([str isEqualToString:@"ktv"]){
        self.ktvLab.textColor = KGBlueColor;
    }
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
