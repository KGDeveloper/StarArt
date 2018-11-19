//
//  KGPerformanceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGPerformanceVC.h"
#import "KGPerformanceCell.h"
#import "KGPerformanceDetailVC.h"

@interface KGPerformanceVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIScrollViewDelegate>
/** 图书列表 */
@property (nonatomic,strong) UITableView *listView;
/** 头视图 */
@property (nonatomic,strong) UIView *headerView;
/** 顶部运动线 */
@property (nonatomic,strong) UIView *line;
/** 默认点击按钮 */
@property (nonatomic,assign) NSInteger selectBtu;
/** 顶部滚动 */
@property (nonatomic,strong) UIScrollView *topScrollView;
/** 顶部滚动新闻 */
@property (nonatomic,strong) UIView *topView;
/** 顶部直线 */
@property (nonatomic,strong) UIView *topLine;
/** 页码 */
@property (nonatomic,strong) UIPageControl *pageControl;
/** 戏剧 */
@property (nonatomic,strong) UIButton *leftBtu;
/** 音乐 */
@property (nonatomic,strong) UIButton *rightBtu;
/** 近期热门 */
@property (nonatomic,strong) UIButton *nearBtu;
/** 即将开始 */
@property (nonatomic,strong) UIButton *theBtu;
/** 即将结束 */
@property (nonatomic,strong) UIButton *endBtu;
/** 底部直线 */
@property (nonatomic,strong) UIView *lowLine;

@end

@implementation KGPerformanceVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectMake(15, 0, 50, 30) title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    [self setNavCenterView];
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏搜索 */
- (void)setNavCenterView{
    UIButton *searchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtu.frame = CGRectMake(0, 0, KGScreenWidth - 130, 30);
    [searchBtu setTitle:@"搜索..." forState:UIControlStateNormal];
    [searchBtu setImage:[UIImage imageNamed:@"sousuohuise"] forState:UIControlStateNormal];
    [searchBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    searchBtu.titleLabel.font = KGFontSHRegular(12);
    searchBtu.layer.cornerRadius = 15;
    searchBtu.layer.masksToBounds = YES;
    searchBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [searchBtu addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchBtu;
}
/** 搜索框点击事件 */
- (void)searchAction{
    
}
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setHeaderView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGPerformanceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGPerformanceCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
/** 代理方法以及数据源 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGPerformanceCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushHideenTabbarViewController:[[KGPerformanceDetailVC alloc]init] animted:YES];
}
/** 头视图 */
- (UIView *)setHeaderView{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/3*2 + 150)];
    /** 按钮 */
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtu.frame  =CGRectMake(0,0, KGScreenWidth/2,50);
    [self.leftBtu setTitle:@"戏剧" forState:UIControlStateNormal];
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.leftBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    self.leftBtu.titleLabel.font = KGFontSHRegular(14);
    [self.leftBtu addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.leftBtu];
    /** 按钮 */
    self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtu.frame  =CGRectMake(KGScreenWidth/2,0, KGScreenWidth/2,50);
    [self.rightBtu setTitle:@"音乐" forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.rightBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    self.rightBtu.titleLabel.font = KGFontSHRegular(14);
    [self.rightBtu addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.rightBtu];
    /** 直线 */
    self.line = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 70, 48, 30, 2)];
    self.line.backgroundColor = KGBlueColor;
    [self.headerView addSubview:self.line];
    /** 顶部滚动 */
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KGScreenWidth, KGScreenWidth/3*2 + 40)];
    [self.headerView addSubview:self.topView];
    /** 滚动图 */
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/3*2 + 40)];
    self.topScrollView.contentSize = CGSizeMake(KGScreenWidth*5, KGScreenWidth/3*2 + 40);
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.bounces = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.delegate = self;
    [self.topView addSubview:self.topScrollView];
    /** 直线 */
    self.topLine = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/3*2 + 90, KGScreenWidth, 10)];
    self.topLine.backgroundColor = KGLineColor;
    [self.headerView addSubview:self.topLine];
    /** 页码 */
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(KGScreenWidth - 75, KGScreenWidth/3*2, 60, 40)];
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = KGGrayColor;
    self.pageControl.currentPageIndicatorTintColor = KGBlackColor;
    [self.topView insertSubview:self.pageControl atIndex:99];
    /** 近期热门 */
    self.nearBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nearBtu.frame  =CGRectMake(0,KGScreenWidth/3*2 + 100, KGScreenWidth/3,50);
    [self.nearBtu setTitle:@"近期热门" forState:UIControlStateNormal];
    [self.nearBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.nearBtu.titleLabel.font = KGFontSHRegular(14);
    [self.nearBtu addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.nearBtu];
    /** 即将开始 */
    self.theBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.theBtu.frame  =CGRectMake(KGScreenWidth/2 - KGScreenWidth/6,KGScreenWidth/3*2 + 100, KGScreenWidth/3,50);
    [self.theBtu setTitle:@"即将开始" forState:UIControlStateNormal];
    [self.theBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.theBtu.titleLabel.font = KGFontSHRegular(14);
    [self.theBtu addTarget:self action:@selector(willStarAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.theBtu];
    /** 即将结束 */
    self.endBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endBtu.frame  =CGRectMake(KGScreenWidth - KGScreenWidth/3,KGScreenWidth/3*2 + 100, KGScreenWidth/3,50);
    [self.endBtu setTitle:@"即将结束" forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.endBtu.titleLabel.font = KGFontSHRegular(14);
    [self.endBtu addTarget:self action:@selector(willEndAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.endBtu];
    /** 直线 */
    UIView *centerline = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/3*2 + 99, KGScreenWidth, 1)];
    centerline.backgroundColor = KGLineColor;
    [self.headerView addSubview:centerline];
    /** 底部直线 */
    self.lowLine = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/6 - 30, KGScreenWidth/3*2 + 148, 60, 2)];
    self.lowLine.backgroundColor = KGBlueColor;
    [self.headerView addSubview:self.lowLine];
    
    return self.headerView;
}
/** 戏剧点击事件 */
- (void)leftAction{
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.center = CGPointMake(KGScreenWidth/2 - 55, 49);
    }];
}
/** 音乐点击事件 */
- (void)rightAction{
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.center = CGPointMake(KGScreenWidth/2 + 55, 49);
    }];
}
/** 近期热门点击事件 */
- (void)hotAction{
    [self.nearBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.theBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowLine.center = CGPointMake(self.nearBtu.center.x, KGScreenWidth/3*2 + 149);
    }];
}
/** 即将开始点击事件 */
- (void)willStarAction{
    [self.nearBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.theBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowLine.center = CGPointMake(self.theBtu.center.x, KGScreenWidth/3*2 + 149);
    }];
}
/** 即将结束点击事件 */
- (void)willEndAction{
    [self.nearBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.theBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowLine.center = CGPointMake(self.endBtu.center.x, KGScreenWidth/3*2 + 149);
    }];
}
/** 创建滚动广告 */
- (UIView *)createNewsViewWithImage:(UIImage *)image labTitle:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag{
    UIView *addView = [[UIView alloc]initWithFrame:frame];
    /** 按钮 */
    UIButton *tmpBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpBtu.frame = CGRectMake(0, 0, KGScreenWidth,KGScreenWidth/3*2);
    [tmpBtu setImage:image forState:UIControlStateNormal];
    tmpBtu.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [tmpBtu addTarget:self action:@selector(topBtuAction:) forControlEvents:UIControlEventTouchUpInside];
    tmpBtu.tag = tag;
    [addView addSubview:tmpBtu];
    /** lab */
    UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/3*2, KGScreenWidth - 100, 40)];
    tmpLab.text = title;
    tmpLab.textColor = KGBlackColor;
    tmpLab.font = KGFontSHRegular(14);
    [addView addSubview:tmpLab];
    return addView;
}
/** 广告点击事件 */
- (void)topBtuAction:(UIButton *)sender{
    
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
