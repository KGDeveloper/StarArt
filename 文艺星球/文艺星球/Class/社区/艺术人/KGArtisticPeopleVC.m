//
//  KGArtisticPeopleVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGArtisticPeopleVC.h"
#import "KGArtisticPeopleCell.h"
#import "KGArtisticPeopleDetailVC.h"

@interface KGArtisticPeopleVC()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 艺术人列表 */
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger pageIndex;

@end

@implementation KGArtisticPeopleVC

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
    self.title = @"艺术人";
    
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    
    [self requestData];
    [self setUpListView];
}
/** 请求数据 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:selectArtistList parameters:@{@"pageIndex":@(self.pageIndex),@"pageSize":@"20"} succ:^(id  _Nonnull result) {
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
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
// MARK: --创建列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
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
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGArtisticPeopleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGArtisticPeopleCell"];
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
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGArtisticPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGArtisticPeopleCell"];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self pushHideenTabbarViewController:[[KGArtisticPeopleDetailVC alloc]init] animted:YES];
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
