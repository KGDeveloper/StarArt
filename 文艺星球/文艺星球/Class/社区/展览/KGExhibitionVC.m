//
//  KGExhibitionVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGExhibitionVC.h"
#import "KGExhibitionVCListViewCell.h"
#import "KGAgencyExhibitionDetailVC.h"

@interface KGExhibitionVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIScrollViewDelegate>
/** 展览列表 */
@property (nonatomic,strong) UITableView *listView;
/** 美术 */
@property (nonatomic,strong) UIButton *artsBtu;
/** 摄影 */
@property (nonatomic,strong) UIButton *photographyBtu;
/** 设计 */
@property (nonatomic,strong) UIButton *designBtu;
/** 蓝色线条 */
@property (nonatomic,strong) UIView *moveLine;
/** 顶部滚动 */
@property (nonatomic,strong) UIScrollView *topScrollView;
/** 页码 */
@property (nonatomic,strong) UIPageControl *pageControl;
/** 近期热门 */
@property (nonatomic,strong) UIButton *nearBtu;
/** 即将开始 */
@property (nonatomic,strong) UIButton *willBtu;
/** 即将结束 */
@property (nonatomic,strong) UIButton *endBtu;
/** 底部滚动线条 */
@property (nonatomic,strong) UIView *lowMoveLine;

@end

@implementation KGExhibitionVC

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
// MARK: --创建展览列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUpHeaderView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGExhibitionVCListViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGExhibitionVCListViewCell"];
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
    return (KGScreenWidth - 30)/69*40 + 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGExhibitionVCListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGExhibitionVCListViewCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushHideenTabbarViewController:[[KGAgencyExhibitionDetailVC alloc]init] animted:YES];
}
/** 头视图 */
- (UIView *)setUpHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/3*2 + 150)];
// MARK: --顶部切换按钮--
    /** 美术 */
    self.artsBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.artsBtu.frame = CGRectMake(KGScreenWidth/2 - 125, 0, 80, 50);
    [self.artsBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.artsBtu setTitle:@"美术" forState:UIControlStateNormal];
    self.artsBtu.titleLabel.font = KGFontSHRegular(15);
    [self.artsBtu addTarget:self action:@selector(artAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.artsBtu];
    /** 摄影 */
    self.photographyBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photographyBtu.frame = CGRectMake(KGScreenWidth/2 - 40, 0, 80, 50);
    [self.photographyBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.photographyBtu setTitle:@"摄影" forState:UIControlStateNormal];
    self.photographyBtu.titleLabel.font = KGFontSHRegular(15);
    [self.photographyBtu addTarget:self action:@selector(photographyAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.photographyBtu];
    /** 设计 */
    self.designBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.designBtu.frame = CGRectMake(KGScreenWidth/2 + 45, 0, 80, 50);
    [self.designBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.designBtu setTitle:@"设计" forState:UIControlStateNormal];
    self.designBtu.titleLabel.font = KGFontSHRegular(15);
    [self.designBtu addTarget:self action:@selector(designAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.designBtu];
    /** 移动直线 */
    self.moveLine = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 100, 48, 30, 2)];
    self.moveLine.backgroundColor = KGBlueColor;
    [headerView addSubview:self.moveLine];
// MARK: --滚动模块--
    /** 滚动图 */
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, KGScreenWidth, KGScreenWidth/3*2 + 40)];
    self.topScrollView.contentSize = CGSizeMake(KGScreenWidth*5, KGScreenWidth/3*2 + 40);
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.bounces = NO;
    self.topScrollView.delegate = self;
    [headerView addSubview:self.topScrollView];
    /** 页码 */
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(KGScreenWidth - 75, KGScreenWidth/3*2 + 50, 60, 40)];
    self.pageControl.numberOfPages = 5;
    self.pageControl.pageIndicatorTintColor = KGGrayColor;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = KGBlueColor;
    [headerView addSubview:self.pageControl];
    /** 顶部直线 */
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0,KGScreenWidth/3*2 + 90, KGScreenWidth, 10)];
    topLine.backgroundColor = KGLineColor;
    [headerView addSubview:topLine];
// MARK: --底部切换按钮--
    /** 近期热门 */
    self.nearBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nearBtu.frame = CGRectMake(0, KGScreenWidth/3*2 + 100, KGScreenWidth/3, 50);
    [self.nearBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.nearBtu setTitle:@"近期热门" forState:UIControlStateNormal];
    self.nearBtu.titleLabel.font = KGFontSHRegular(15);
    [self.nearBtu addTarget:self action:@selector(nearAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.nearBtu];
    /** 竖直线 */
    UIView *leftVLine = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/3, KGScreenWidth/3*2 + 110, 1, 30)];
    leftVLine.backgroundColor = KGLineColor;
    [headerView addSubview:leftVLine];
    /** 即将开始 */
    self.willBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.willBtu.frame = CGRectMake(KGScreenWidth/3, KGScreenWidth/3*2 + 100, KGScreenWidth/3, 50);
    [self.willBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.willBtu setTitle:@"即将开始" forState:UIControlStateNormal];
    self.willBtu.titleLabel.font = KGFontSHRegular(15);
    [self.willBtu addTarget:self action:@selector(willSatrAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.willBtu];
    /** 竖直线 */
    UIView *rightVLine = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth - KGScreenWidth/3, KGScreenWidth/3*2 + 110, 1, 30)];
    rightVLine.backgroundColor = KGLineColor;
    [headerView addSubview:rightVLine];
    /** 即将结束 */
    self.endBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endBtu.frame = CGRectMake(KGScreenWidth - KGScreenWidth/3, KGScreenWidth/3*2 + 100, KGScreenWidth/3, 50);
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitle:@"即将结束" forState:UIControlStateNormal];
    self.endBtu.titleLabel.font = KGFontSHRegular(15);
    [self.endBtu addTarget:self action:@selector(endSatrAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.endBtu];
    /** 底部直线 */
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/3*2 + 149, KGScreenWidth, 1)];
    lowLine.backgroundColor = KGLineColor;
    [headerView addSubview:lowLine];
    /** 底部移动直线 */
    self.lowMoveLine = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/6 - 30, KGScreenWidth/3*2 + 148, 60, 2)];
    self.lowMoveLine.backgroundColor = KGBlueColor;
    [headerView addSubview:self.lowMoveLine];
    
    return headerView;
}
/** 美术点击事件 */
- (void)artAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.designBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.photographyBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLine.center = CGPointMake(sender.centerX, 48);
    }];
}
/** 摄影点击事件 */
- (void)photographyAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.designBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.artsBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLine.center = CGPointMake(sender.centerX, 48);
    }];
}
/** 设计点击事件 */
- (void)designAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.artsBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.photographyBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLine.center = CGPointMake(sender.centerX, 48);
    }];
}
/** 近期热门点击事件 */
- (void)nearAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.willBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowMoveLine.center = CGPointMake(sender.centerX, KGScreenWidth/3*2 + 149);
    }];
}
/** 即将开始点击事件 */
- (void)willSatrAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.nearBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowMoveLine.center = CGPointMake(sender.centerX, KGScreenWidth/3*2 + 149);
    }];
}
/** 即将结束点击事件 */
- (void)endSatrAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.willBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.nearBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowMoveLine.center = CGPointMake(sender.centerX, KGScreenWidth/3*2 + 149);
    }];
}
/** 设置页码 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.topScrollView.contentOffset.x/KGScreenWidth;
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
