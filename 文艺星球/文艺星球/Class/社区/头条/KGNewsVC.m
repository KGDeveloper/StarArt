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
@property (nonatomic,copy) NSString *valueStr;
@property (nonatomic,copy) NSString *wordStr;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,copy) NSArray *topArr;

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
    
    self.valueStr = @"";
    self.wordStr = @"";
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    
    [self requestData];
    [self requestFiveData];
    [self setNavCenterView];
    self.selectBtu = 0;
    [self setUpListView];
    
}
/** 请求数据 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectNewsList parameters:@{@"value":self.valueStr,@"valueWord":self.wordStr,@"pageIndex":@(self.pageIndex),@"pageSize":@"20"} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView reloadData];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [weakSelf.listView reloadData];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
    }];
}
/** 请求顶部5条 */
- (void)requestFiveData{
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectNewsListFives parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            weakSelf.topArr = dic[@"list"];
        }
        [weakSelf setUpTopScrollView];
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        
    }];
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
    self.valueStr = sender.currentTitle;
    if ([sender.currentTitle isEqualToString:@"全部"]) {
        self.valueStr = @"";
    }
    self.wordStr = @"";
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    [self requestData];
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
    __weak typeof(self) weakSelf = self;
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf requestData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf requestData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGNewsCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
/** 代理方法以及数据源 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 380;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsCell"];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    KGNewsDetailVC *vc = [[KGNewsDetailVC alloc]init];
    vc.sendID = [NSString stringWithFormat:@"%@",dic[@"nid"]];
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 滚动视图代理 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScrollView) {
        self.pageControl.currentPage = self.topScrollView.contentOffset.x/KGScreenWidth;
    }
}
/** 创建滚动广告 */
- (void)setUpTopScrollView{
    self.topScrollView.contentSize = CGSizeMake(KGScreenWidth*self.topArr.count, KGScreenWidth/3*2 + 40);
    for (int i = 0; i < self.topArr.count; i++) {
        NSDictionary *dic = self.topArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth*i, 0, KGScreenWidth, KGScreenWidth/3*2)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[dic[@"newsCover"] componentsSeparatedByString:@"#"] firstObject]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.tag = [dic[@"nid"] integerValue];
        [self.topScrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookNewsDetailAction:)];
        [imageView addGestureRecognizer:tap];
        
        UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(KGScreenWidth*i + 15, KGScreenWidth/3*2, KGScreenWidth - 75, 40)];
        tmpLab.text = dic[@"newsTitle"];
        tmpLab.textColor = KGBlackColor;
        tmpLab.font = KGFontSHRegular(14);
        [self.topScrollView addSubview:tmpLab];
    }
}
/** 点击查看详情 */
- (void)lookNewsDetailAction:(UITapGestureRecognizer *)tap{
    KGNewsDetailVC *vc = [[KGNewsDetailVC alloc]init];
    vc.sendID = [NSString stringWithFormat:@"%ld",tap.view.tag];
    [self pushHideenTabbarViewController:vc animted:YES];
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
