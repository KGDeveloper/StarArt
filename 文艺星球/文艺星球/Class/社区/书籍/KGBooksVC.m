//
//  KGBooksVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBooksVC.h"
#import "KGBooksCell.h"
#import "KGBooksView.h"
#import "KGRecommendBooksVC.h"
#import "KGBestSellingBooksVC.h"
#import "KGBooksDetailVC.h"

@interface KGBooksVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 图书列表 */
@property (nonatomic,strong) UITableView *listView;
/** 今日推荐 */
@property (nonatomic,strong) UIScrollView *recommendScrollView;
/** 畅销图书榜 */
@property (nonatomic,strong) UIScrollView *hotScrollView;
/** 今日推荐 */
@property (nonatomic,copy) NSArray *topArr;
/** 畅销 */
@property (nonatomic,copy) NSArray *hotArr;
/** 感兴趣 */
@property (nonatomic,copy) NSArray *dataArr;

@end

@implementation KGBooksVC

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
    
    [self requestData];
    [self setNavCenterView];
    [self setUpListView];
}
/** 请求数据 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectBookList parameters:@{} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            weakSelf.topArr = dic[@"recommendedList"];
            weakSelf.hotArr = dic[@"bestSellerList"];
            weakSelf.dataArr = dic[@"interestedList"];
            weakSelf.hotScrollView.contentSize = CGSizeMake(weakSelf.hotArr.count*115, 195);
            weakSelf.recommendScrollView.contentSize = CGSizeMake(weakSelf.topArr.count*115, 195);
            [weakSelf setRecommendScrollViewSubViews];
            [weakSelf setHotScrollViewSubViews];
        }
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
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
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUpTopScrollView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
 
    [self.listView registerNib:[UINib nibWithNibName:@"KGBooksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGBooksCell"];
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
    return 170;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGBooksCell"];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDactionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushHideenTabbarViewController:[[KGBooksDetailVC alloc]init] animted:YES];
}
/** 列表头 */
- (UIView *)setUpTopScrollView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 560)];
    headerView.backgroundColor = KGWhiteColor;
    /** 今日推荐 */
    UILabel *recommendLab = [[UILabel alloc]initWithFrame:CGRectMake(15,0 , KGScreenWidth, 50)];
    recommendLab.text = @"今日推荐";
    recommendLab.textColor = KGBlackColor;
    recommendLab.font = KGFontSHBold(14);
    [headerView addSubview:recommendLab];
    /** 打开按钮 */
    UIButton *topRightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    topRightBtu.frame = CGRectMake(KGScreenWidth - 150, 0, 135, 50);
    [topRightBtu setImage:[UIImage imageNamed:@"dakai"] forState:UIControlStateNormal];
    topRightBtu.imageEdgeInsets = UIEdgeInsetsMake(19, 0, 19, 0);
    topRightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    topRightBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [topRightBtu addTarget:self action:@selector(topRightAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:topRightBtu];
    /** 今日推荐滚动 */
    self.recommendScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, KGScreenWidth, 195)];
    self.recommendScrollView.contentSize = CGSizeMake(575, 195);
    self.recommendScrollView.pagingEnabled = YES;
    self.recommendScrollView.showsVerticalScrollIndicator = NO;
    self.recommendScrollView.showsHorizontalScrollIndicator = NO;
    [headerView addSubview:self.recommendScrollView];
    
    /** 顶部直线 */
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 245, KGScreenWidth, 10)];
    topLine.backgroundColor = KGLineColor;
    [headerView addSubview:topLine];
    /** 畅销图书榜 */
    UILabel *hotLab = [[UILabel alloc]initWithFrame:CGRectMake(15,255 , KGScreenWidth, 50)];
    hotLab.text = @"畅销图书榜";
    hotLab.textColor = KGBlackColor;
    hotLab.font = KGFontSHBold(14);
    [headerView addSubview:hotLab];
    /** 打开按钮 */
    UIButton *lowRightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    lowRightBtu.frame = CGRectMake(KGScreenWidth - 150,255, 135, 50);
    [lowRightBtu setImage:[UIImage imageNamed:@"dakai"] forState:UIControlStateNormal];
    lowRightBtu.imageEdgeInsets = UIEdgeInsetsMake(19, 0, 19, 0);
    lowRightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    lowRightBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [lowRightBtu addTarget:self action:@selector(lowRightAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:lowRightBtu];
    /** 畅销图书榜滚动 */
    self.hotScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 305, KGScreenWidth, 195)];
    self.hotScrollView.pagingEnabled = YES;
    self.hotScrollView.showsVerticalScrollIndicator = NO;
    self.hotScrollView.showsHorizontalScrollIndicator = NO;
    [headerView addSubview:self.hotScrollView];
    
    /** 低部直线 */
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 500, KGScreenWidth, 10)];
    lowLine.backgroundColor = KGLineColor;
    [headerView addSubview:lowLine];
    /** 可能感兴趣 */
    UILabel *mayLab = [[UILabel alloc]initWithFrame:CGRectMake(15,510 , KGScreenWidth, 50)];
    mayLab.text = @"你可能感兴趣的";
    mayLab.textColor = KGBlackColor;
    mayLab.font = KGFontSHBold(14);
    [headerView addSubview:mayLab];
    
    return headerView;
}
/** 查看今日推荐 */
- (void)topRightAction{
    [self pushHideenTabbarViewController:[[KGRecommendBooksVC alloc]init] animted:YES];
}
/** 查看畅销图书榜 */
- (void)lowRightAction{
    [self pushHideenTabbarViewController:[[KGBestSellingBooksVC alloc]init] animted:YES];
}
/** 顶部滚动 */
- (void)setRecommendScrollViewSubViews{
    for (int i = 0; i < self.topArr.count; i++) {
        KGBooksView *booksView = [[KGBooksView alloc]initWithFrame:CGRectMake(15+115*i, 0, 100, 195)];
        [self.recommendScrollView addSubview:booksView];
        NSDictionary *dic = self.topArr[i];
        [booksView viewDetailWithDictionary:dic];
    }
}
/** 畅销滚动 */
- (void)setHotScrollViewSubViews{
    for (int i = 0; i < self.hotArr.count; i++) {
        KGBooksView *booksView = [[KGBooksView alloc]initWithFrame:CGRectMake(15+115*i, 0, 100, 195)];
        [self.hotScrollView addSubview:booksView];
        NSDictionary *dic = self.hotArr[i];
        [booksView viewDetailWithDictionary:dic];
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
