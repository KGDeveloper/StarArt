//
//  KGInstitutionDramaTheUpcomingVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionDramaTheUpcomingVC.h"
#import "KGInstitutionHotDramaCell.h"
#import "KGInstitutionDramaDetailVC.h"

@interface KGInstitutionDramaTheUpcomingVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
/** 导航左侧 */
@property (nonatomic,strong) UIButton *leftBtu;
/** 导航右侧 */
@property (nonatomic,strong) UIButton *rightBtu;
/** 页码 */
@property (nonatomic,assign) NSInteger page;
/** 近期热门 */
@property (nonatomic,copy) NSString *navigationStr;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGInstitutionDramaTheUpcomingVC

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
    self.title = @"即将上映";
    self.view.backgroundColor = KGAreaGrayColor;
    self.navigationStr = @"即将上映";
    self.page = 1;
    self.dataArr = [NSMutableArray array];
    
    [self requestData];
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
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectShowList parameters:@{@"pageIndex":@(self.page),@"pageSize":@"20",@"typeID":@"5",@"cityID":cityId,@"mohu":@"",@"navigation":self.navigationStr} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView reloadData];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView.mj_header endRefreshing];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [weakSelf.listView reloadData];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView.mj_header endRefreshing];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 列表 */
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
        weakSelf.page = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf requestData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGInstitutionHotDramaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGInstitutionHotDramaCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGInstitutionHotDramaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGInstitutionHotDramaCell" forIndexPath:indexPath];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGInstitutionDramaDetailVC *vc = [[KGInstitutionDramaDetailVC alloc]initWithNibName:@"KGInstitutionDramaDetailVC" bundle:nil];
    NSDictionary *dic = self.dataArr[indexPath.row];
    vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
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
