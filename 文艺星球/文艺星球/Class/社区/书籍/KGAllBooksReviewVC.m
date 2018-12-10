//
//  KGAllBooksReviewVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAllBooksReviewVC.h"
#import "KGWriteReviewVC.h"
#import "KGAllBooksReviewCell.h"

@interface KGAllBooksReviewVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 图书列表 */
@property (nonatomic,strong) UITableView *listView;
/** 所有书评 */
@property (nonatomic,strong) UIButton *allReviewBtu;
/** 热门书评 */
@property (nonatomic,strong) UIButton *hotReviewBtu;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,copy) NSString *navigations;

@end

@implementation KGAllBooksReviewVC

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
    [self setRightNavItemWithFrame:CGRectZero title:@"写书评" image:nil font:KGFontSHRegular(14) color:KGBlueColor select:@selector(rightNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    self.dataArr = [NSMutableArray array];
    self.pageIndex = 1;
    self.navigations = @"全部评论";
    
    [self reuqestData];
    [self setUpListView];
}
/** 请求数据 */
- (void)reuqestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectBookCommetnByCid parameters:@{@"id":self.sendID,@"navigations":self.navigations,@"navigation":@"查看全部评论",@"pageIndex":@(self.pageIndex),@"pageSize":@"20"} succ:^(id  _Nonnull result) {
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
/** 导航栏右侧按钮点击事件 */
- (void)rightNavAction{
    KGWriteReviewVC *vc = [[KGWriteReviewVC alloc]initWithNibName:@"KGWriteReviewVC" bundle:[NSBundle mainBundle]];
    vc.sendID = self.sendID;
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 设置头视图 */
- (UIView *)setUpHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 60)];
    UIView *btuBackView = [[UIView alloc]initWithFrame:CGRectMake((KGScreenWidth - 160)/2, 15, 160, 30)];
    btuBackView.backgroundColor = KGBlueColor;
    btuBackView.layer.cornerRadius = 15;
    btuBackView.layer.masksToBounds = YES;
    [headerView addSubview:btuBackView];
    /** 所有书评 */
    self.allReviewBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allReviewBtu.frame = CGRectMake(1, 1, 79, 28);
    self.allReviewBtu.backgroundColor = KGWhiteColor;
    [self.allReviewBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.allReviewBtu setTitle:@"全部书评" forState:UIControlStateNormal];
    self.allReviewBtu.titleLabel.font = KGFontSHRegular(12);
    [self.allReviewBtu addTarget:self action:@selector(allReviewAction:) forControlEvents:UIControlEventTouchUpInside];
    [btuBackView addSubview:self.allReviewBtu];
    /** 热门书评 */
    self.hotReviewBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hotReviewBtu.frame = CGRectMake(80, 1, 79, 28);
    self.hotReviewBtu.backgroundColor = KGBlueColor;
    [self.hotReviewBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    [self.hotReviewBtu setTitle:@"热门书评" forState:UIControlStateNormal];
    self.hotReviewBtu.titleLabel.font = KGFontSHRegular(12);
    [self.hotReviewBtu addTarget:self action:@selector(hotReviewAction:) forControlEvents:UIControlEventTouchUpInside];
    [btuBackView addSubview:self.hotReviewBtu];
    
    return headerView;
}
/** 全部书评点击事件 */
- (void)allReviewAction:(UIButton *)sender{
    [sender setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    sender.backgroundColor = KGBlueColor;
    [self.hotReviewBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    self.hotReviewBtu.backgroundColor = KGWhiteColor;
    self.dataArr = [NSMutableArray array];
    self.pageIndex = 1;
    self.navigations = @"全部评论";
    [self reuqestData];
}
/** 热门书评点击事件 */
- (void)hotReviewAction:(UIButton *)sender{
    [sender setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    sender.backgroundColor = KGBlueColor;
    [self.allReviewBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    self.allReviewBtu.backgroundColor = KGWhiteColor;
    self.dataArr = [NSMutableArray array];
    self.pageIndex = 1;
    self.navigations = @"热门书评";
    [self reuqestData];
}
// MARK: --创建机构列表--
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
        [weakSelf reuqestData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf reuqestData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:self.listView];
    
    [self.listView registerClass:[KGAllBooksReviewCell class] forCellReuseIdentifier:@"KGAllBooksReviewCell"];
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
    KGAllBooksReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAllBooksReviewCell"];
    NSDictionary *dic = self.dataArr[indexPath.row];
    return [cell cellHeightWithDictionary:dic];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGAllBooksReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAllBooksReviewCell"];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
