//
//  KGInstitutionVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionVC.h"
#import "KGAgencyHomePageVC.h"
#import "KGInstitutionDramaVC.h"

@interface KGInstitutionVC ()<UITextFieldDelegate,UIScrollViewDelegate>
/** 底部加载 */
@property (nonatomic,strong) UIScrollView *backScroll;
/** 顶部滚动 */
@property (nonatomic,strong) UIScrollView *topScroll;
/** 搜索感兴趣场馆 */
@property (nonatomic,strong) UITextField *searchTF;
/** 页数 */
@property (nonatomic,strong) UIPageControl *pageCol;
/** 近期热门 */
@property (nonatomic,strong) UIScrollView *hotScroll;
/** 最新活动 */
@property (nonatomic,strong) UIScrollView *newsScroll;

@end

@implementation KGInstitutionVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGBlueColor controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"机构";
    
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建ui */
- (void)setUI{
    self.backScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.backScroll.contentSize = self.view.bounds.size;
    self.backScroll.showsVerticalScrollIndicator = NO;
    self.backScroll.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.backScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.backScroll.bounces = NO;
    [self.view addSubview:self.backScroll];
    
    /** 蓝色背景 */
    UIView *backBlue = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 175 + KGRectNavAndStatusHight)];
    backBlue.backgroundColor = KGBlueColor;
    [self.backScroll addSubview:backBlue];
    /** 搜索框 */
    self.searchTF = [[UITextField alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 25, KGScreenWidth - 30, 30)];
    self.searchTF.delegate = self;
    self.searchTF.backgroundColor = [UIColor colorWithHexString:@"#76a3ff"];
    self.searchTF.textAlignment = NSTextAlignmentCenter;
    self.searchTF.text = @"搜索喜欢的场馆";
    self.searchTF.font = KGFontSHRegular(12);
    self.searchTF.textColor = KGWhiteColor;
    self.searchTF.layer.cornerRadius = 15;
    self.searchTF.layer.masksToBounds = YES;
    [self.backScroll addSubview:self.searchTF];
    /** 顶部滚动图 */
    self.topScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, KGRectNavAndStatusHight + 65, KGScreenWidth - 20 , 120)];
    self.topScroll.contentSize = CGSizeMake((KGScreenWidth - 20)*5, 120);
    self.topScroll.showsVerticalScrollIndicator = NO;
    self.topScroll.showsHorizontalScrollIndicator = NO;
    self.topScroll.delegate = self;
    self.topScroll.pagingEnabled = YES;
    self.topScroll.bounces = NO;
    self.topScroll.layer.cornerRadius = 5;
    self.topScroll.layer.masksToBounds = YES;
    [self.backScroll addSubview:self.topScroll];
    
    [self setScrollView];
    /** 页码 */
    self.pageCol = [[UIPageControl alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 165, KGScreenWidth, 5)];
    self.pageCol.numberOfPages = 5;
    self.pageCol.currentPage = 0;
    self.pageCol.pageIndicatorTintColor = KGWhiteColor;
    self.pageCol.currentPageIndicatorTintColor = KGBlueColor;
    [self.backScroll addSubview:self.pageCol];
    /** 选择机构类型 */
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 345, 190)];
    backView.center = CGPointMake(KGScreenWidth/2, 270 + KGRectNavAndStatusHight);
    backView.backgroundColor = KGWhiteColor;
    backView.layer.cornerRadius = 5;
    backView.layer.borderColor = KGLineColor.CGColor;
    backView.layer.borderWidth = 1;
    backView.layer.masksToBounds = YES;
    [self.backScroll addSubview:backView];
    /** 点击按钮 */
    NSArray *imageArr = @[[UIImage imageNamed:@"meishu"],[UIImage imageNamed:@"sheji"],[UIImage imageNamed:@"sheying"],[UIImage imageNamed:@"xiju"],[UIImage imageNamed:@"dianying"],[UIImage imageNamed:@"yinyue"],[UIImage imageNamed:@"meishi"],[UIImage imageNamed:@"juyuan"]];
    NSArray *titleArr = @[@"美术",@"设计",@"摄影",@"戏剧",@"电影",@"音乐",@"美食",@"剧院"];
    for (int i = 0; i < 8; i++) {
        if (i < 4) {
            [backView addSubview:[self createWtihFrame:CGRectMake(((345 - 320)/3 + 80)*i, 0, 80, 80) title:titleArr[i] image:imageArr[i] tag:999+i]];
        }else{
            [backView addSubview:[self createWtihFrame:CGRectMake(((345 - 320)/3 + 80)*(i-4), 90, 80, 80) title:titleArr[i] image:imageArr[i] tag:999+i]];
        }
    }
    /** 近期热门 */
    UILabel *hotLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 395 + KGRectNavAndStatusHight, KGScreenWidth - 30, 15)];
    hotLab.textColor = KGBlackColor;
    hotLab.text = @"近期热门";
    hotLab.font = KGFontSHBold(15);
    [self.backScroll addSubview:hotLab];
    /** 最新活动 */
    UILabel *newsLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 545 + KGRectNavAndStatusHight, KGScreenWidth - 30, 15)];
    newsLab.textColor = KGBlackColor;
    newsLab.text = @"最新活动";
    newsLab.font = KGFontSHBold(15);
    [self.backScroll addSubview:newsLab];
    /** 热门滚动 */
    self.hotScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 425 + KGRectNavAndStatusHight, KGScreenWidth - 15 , 100)];
    self.hotScroll.contentSize = CGSizeMake(540, 100);
    self.hotScroll.showsVerticalScrollIndicator = NO;
    self.hotScroll.showsHorizontalScrollIndicator = NO;
    self.hotScroll.pagingEnabled = YES;
    self.hotScroll.bounces = NO;
    [self.backScroll addSubview:self.hotScroll];
    for (int i = 0; i < 5; i++) {
        [self.hotScroll addSubview:[self createImageAndTitleWithFrame:CGRectMake(110*i, 0, 100, 100) title:@"你好啊" image:nil tag:1999+i]];
    }
    /** 活动滚动 */
    self.newsScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 575 + KGRectNavAndStatusHight, KGScreenWidth - 15 , 100)];
    self.newsScroll.contentSize = CGSizeMake(540, 100);
    self.newsScroll.showsVerticalScrollIndicator = NO;
    self.newsScroll.showsHorizontalScrollIndicator = NO;
    self.newsScroll.pagingEnabled = YES;
    self.newsScroll.bounces = NO;
    [self.backScroll addSubview:self.newsScroll];
    for (int i = 0; i < 5; i++) {
        [self.newsScroll addSubview:[self createImageAndTitleWithFrame:CGRectMake(110*i, 0, 100, 100) title:@"哈哈哈" image:nil tag:2999+i]];
    }
    
    self.backScroll.contentSize = CGSizeMake(KGScreenWidth, 690 + KGRectNavAndStatusHight);
    
}
/** 监听输入 */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.searchTF.text isEqualToString:@"搜索喜欢的场馆"]) {
        self.searchTF.text = @"";
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.searchTF.text.length < 1) {
        self.searchTF.text = @"搜索喜欢的场馆";
    }
}
/** 创建滚动图 */
- (void)setScrollView{
    for (int i = 0; i < 5; i++) {
        KGImageView *imageView = [[KGImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 20)*i, 0, KGScreenWidth - 20, 120)];
        imageView.deleteBtu.hidden = YES;
        imageView.backgroundColor = KGLineColor;
        [self.topScroll addSubview:imageView];
    }
}
/** 滚动视图代理 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScroll) {
        self.pageCol.currentPage = scrollView.contentOffset.x/(KGScreenWidth - 20);
    }
}
/** 点击按钮 */
- (UIView *)createWtihFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag{
    UIView *btuView = [[UIView alloc]initWithFrame:frame];
    UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 11, frame.size.width, 11)];
    tmpLab.text = title;
    tmpLab.textAlignment = NSTextAlignmentCenter;
    tmpLab.textColor = KGBlackColor;
    tmpLab.font = KGFontSHRegular(11);
    [btuView addSubview:tmpLab];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 20, 20)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btuView addSubview:imageView];
    
    UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = btuView.bounds;
    btu.tag = tag;
    [btu addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [btuView addSubview:btu];
    
    return btuView;
}
/** 点击事件 */
- (void)selectAction:(UIButton *)sender{
    if (sender.tag == 999) {
        /** 美术 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleArts;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1000){
        /** 设计 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleDesign;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1001){
        /** 摄影 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStylePhotography;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1002){
        /** 戏剧 */
        KGInstitutionDramaVC *vc = [[KGInstitutionDramaVC alloc]init];
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1003){
        /** 电影 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleMovies;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1004){
        /** 音乐 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleMusic;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1005){
        /** 美食 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleFood;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1006){
        /** 剧院 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleTheatre;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1999){
        
    }else if (sender.tag == 2000){
        
    }else if (sender.tag == 2001){
        
    }else if (sender.tag == 2002){
        
    }else if (sender.tag == 2003){
        
    }else if (sender.tag == 2999){
        
    }else if (sender.tag == 3000){
        
    }else if (sender.tag == 3001){
        
    }else if (sender.tag == 3002){
        
    }else if (sender.tag == 3003){
        
    }
}
/** 图片文字 */
- (UIView *)createImageAndTitleWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageUrl tag:(NSInteger)tag{
    UIView *btuView = [[UIView alloc]initWithFrame:frame];
    UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 26, frame.size.width, 11)];
    tmpLab.text = title;
    tmpLab.textAlignment = NSTextAlignmentCenter;
    tmpLab.textColor = KGWhiteColor;
    tmpLab.font = KGFontSHRegular(11);
    [btuView addSubview:tmpLab];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:btuView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = KGLineColor;
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [btuView addSubview:imageView];
    
    UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = btuView.bounds;
    btu.tag = tag;
    [btu addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [btuView addSubview:btu];
    
    return btuView;
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
