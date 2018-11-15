//
//  KGNewsVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNewsVC.h"
#import "KGNewsCell.h"
#import "KGNewsDetailVC.h"

@interface KGNewsVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIScrollViewDelegate>
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

@end

@implementation KGNewsVC

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
    self.selectBtu = 0;
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
/** 头视图 */
- (UIView *)setHeaderView{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/3*2 + 100)];
    /** 按钮 */
    NSArray *titleArr = @[@"全部",@"美术",@"设计",@"戏剧",@"摄影",@"电影"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *addBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtu.frame = CGRectMake(60*i, 0, 60, 50);
        [addBtu setTitle:titleArr[i] forState:UIControlStateNormal];
        [addBtu addTarget:self action:@selector(selectTopBtuAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == self.selectBtu) {
            [addBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
            addBtu.titleLabel.font = KGFontSHRegular(15);
        }else{
            [addBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
            addBtu.titleLabel.font = KGFontSHRegular(14);
        }
        [self.headerView addSubview:addBtu];
    }
    /** 直线 */
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 48, 30, 2)];
    self.line.backgroundColor = KGBlueColor;
    self.line.center = CGPointMake(30, 49);
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

    return self.headerView;
}
/** 顶部按钮点击事件 */
- (void)selectTopBtuAction:(UIButton *)sender{
    for (id obj in self.headerView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *tmp = obj;
            [tmp setTitleColor:KGGrayColor forState:UIControlStateNormal];
            tmp.titleLabel.font = KGFontSHRegular(14);
        }
    }
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    sender.titleLabel.font = KGFontSHRegular(15);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    if ([sender.currentTitle isEqualToString:@"全部"]) {
        self.topView.hidden = NO;
        self.headerView.frame = CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/3*2 + 100);
        self.topLine.frame  = CGRectMake(0, KGScreenWidth/3*2 + 40, KGScreenWidth, 10);
    }else{
        self.topView.hidden = YES;
        self.headerView.frame = CGRectMake(0, 0, KGScreenWidth, 50);
        self.topLine.frame  = CGRectMake(0, 50, KGScreenWidth, 10);
    }
    [self.listView reloadData];
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
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGNewsCell"];
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
    return 380;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushHideenTabbarViewController:[[KGNewsDetailVC alloc]init] animted:YES];
}
/** 滚动视图代理 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScrollView) {
        self.pageControl.currentPage = self.topScrollView.contentOffset.x/KGScreenWidth;
    }
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
