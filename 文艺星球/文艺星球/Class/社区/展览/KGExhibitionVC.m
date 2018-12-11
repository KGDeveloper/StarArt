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
/** 城市类型 */
@property (nonatomic,copy) NSString *typeID;
/** 近期分类 */
@property (nonatomic,copy) NSString *navigation;
/** 模糊条件 */
@property (nonatomic,copy) NSString *mohu;
/** 搜索页面 */
@property (nonatomic,strong) KGInstitutionSearchView *searchView;
/** 分页 */
@property (nonatomic,assign) NSInteger pageIndex;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 顶部5条 */
@property (nonatomic,copy) NSArray *topScrollArr;

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
    
    self.typeID = @"1";
    self.navigation = @"近期热门";
    self.mohu = @"";
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    
    [self requestTopData];
    [self requestData];
    [self setNavCenterView];
    [self setUpListView];
    
}
/** 请求数据 */
- (void)requestData{
    __block NSString *cityId = nil;
    __weak typeof(self) weakSelf = self;
    [[KGRequest shareInstance] userLocationCity:^(NSString * _Nonnull city) {
        if ([city isEqualToString:@"北京市"]) {
            cityId = @"1";
        }else if ([city isEqualToString:@"天津市"]){
            cityId = @"43";
        }else if ([city isEqualToString:@"西安市"]){
            cityId = @"54";
        }else if ([city isEqualToString:@"广州市"]){
            cityId = @"28";
        }else if ([city isEqualToString:@"成都市"]){
            cityId = @"65";
        }else if ([city isEqualToString:@"上海市"]){
            cityId = @"13";
        }else if ([city isEqualToString:@"深圳市"]){
            cityId = @"36";
        }else{
            cityId = @"1";
        }
        [weakSelf requestWithCity:cityId];
    }];
}
/** 请求 */
- (void)requestWithCity:(NSString *)cityId{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [KGRequest postWithUrl:SelectExhibitionList parameters:@{@"cityID":cityId,@"typeID":self.typeID,@"navigation":self.navigation,@"mohu":self.mohu,@"pageIndex":@(self.pageIndex),@"pageSize":@"20"} succ:^(id  _Nonnull result) {
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
    }];
}
/** 请求5条顶部 */
- (void)requestTopData{
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectExhibitionListFives parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            weakSelf.topScrollArr = dic[@"list"];
        }
        [weakSelf setTopFiveScrollImage];
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
    self.searchView.hidden = NO;
}
- (KGInstitutionSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[KGInstitutionSearchView alloc] shareInstanceWithType:@"展览"];
        __weak typeof(self) weakSelf = self;
        _searchView.sendSearchResult = ^(NSString * _Nonnull result) {
            weakSelf.mohu = result;
            [weakSelf requestData];
        };
        [self.navigationController.view addSubview:_searchView];
    }
    return _searchView;
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
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGExhibitionVCListViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGExhibitionVCListViewCell"];
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
    return (KGScreenWidth - 30)/69*40 + 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGExhibitionVCListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGExhibitionVCListViewCell"];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    KGAgencyExhibitionDetailVC *vc = [[KGAgencyExhibitionDetailVC alloc]init];
    vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 头视图 */
- (UIView *)setUpHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/3*2 + 150)];
    headerView.backgroundColor = KGWhiteColor;
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
    self.typeID = @"1";
    self.pageIndex = 1;
    self.mohu = @"";
    self.dataArr = [NSMutableArray array];
    [self requestData];
}
/** 摄影点击事件 */
- (void)photographyAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.designBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.artsBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLine.center = CGPointMake(sender.centerX, 48);
    }];
    self.typeID = @"6";
    self.pageIndex = 1;
    self.mohu = @"";
    self.dataArr = [NSMutableArray array];
    [self requestData];
}
/** 设计点击事件 */
- (void)designAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.artsBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.photographyBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLine.center = CGPointMake(sender.centerX, 48);
    }];
    self.typeID = @"4";
    self.pageIndex = 1;
    self.mohu = @"";
    self.dataArr = [NSMutableArray array];
    [self requestData];
}
/** 近期热门点击事件 */
- (void)nearAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.willBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowMoveLine.center = CGPointMake(sender.centerX, KGScreenWidth/3*2 + 149);
    }];
    self.navigation = @"近期热门";
    self.mohu = @"";
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    [self requestData];
}
/** 即将开始点击事件 */
- (void)willSatrAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.nearBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.endBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowMoveLine.center = CGPointMake(sender.centerX, KGScreenWidth/3*2 + 149);
    }];
    self.navigation = @"即将开始";
    self.mohu = @"";
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    [self requestData];
}
/** 即将结束点击事件 */
- (void)endSatrAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.willBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.nearBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.lowMoveLine.center = CGPointMake(sender.centerX, KGScreenWidth/3*2 + 149);
    }];
    self.navigation = @"即将结束";
    self.pageIndex = 1;
    self.mohu = @"";
    self.dataArr = [NSMutableArray array];
    [self requestData];
}
/** 设置页码 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.topScrollView.contentOffset.x/KGScreenWidth;
}
/** 顶部5条数据 */
- (void)setTopFiveScrollImage{
    if (self.topScrollArr.count > 0) {
        for (int i = 0; i < self.topScrollArr.count; i++) {
            NSDictionary *dic = self.topScrollArr[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth*i, 0, KGScreenWidth, KGScreenWidth/3*2)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[dic[@"exhibitionCover"] componentsSeparatedByString:@"#"] firstObject]]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.layer.masksToBounds = YES;
            imageView.userInteractionEnabled = YES;
            imageView.tag = [dic[@"id"] integerValue];
            [self.topScrollView addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagScrollViewLookDetail:)];
            [imageView addGestureRecognizer:tap];
            
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(KGScreenWidth*i + 15, KGScreenWidth/3*2, KGScreenWidth - 15, 40)];
            titleLab.textColor = KGBlackColor;
            titleLab.font = KGFontSHRegular(13);
            titleLab.text = dic[@"exhibitionTitle"];
            [self.topScrollView addSubview:titleLab];
        }
    }
}
/** 点击事件 */
- (void)tagScrollViewLookDetail:(UITapGestureRecognizer *)tap{
    KGAgencyExhibitionDetailVC *vc = [[KGAgencyExhibitionDetailVC alloc]init];
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
