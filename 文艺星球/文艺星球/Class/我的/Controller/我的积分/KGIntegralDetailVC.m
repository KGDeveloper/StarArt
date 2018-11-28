//
//  KGIntegralDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGIntegralDetailVC.h"
#import "KGIntegralTableViewCell.h"

@interface KGIntegralDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 登录积分详情 */
@property (nonatomic,strong) UITableView *listView;
/** 页数 */
@property (nonatomic,assign) NSInteger page;
/** 积分详情 */
@property (nonatomic,strong) NSMutableArray *integerArr;

@end

@implementation KGIntegralDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"积分明细";
    self.page = 1;
    self.integerArr = [NSMutableArray array];
    self.view.backgroundColor = KGWhiteColor;
    [self requestIntegerDetail];
    [self setListView];
}
/** 请求积分详情 */
- (void)requestIntegerDetail{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequest postWithUrl:FindIntegerDetails parameters:@{@"id":[KGUserInfo shareInstance].userId,@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *listDic = result[@"data"];
            NSArray *arr = listDic[@"list"];
            if (arr.count > 0) {
                [weakSelf.integerArr addObjectsFromArray:arr];
            }
            [weakSelf.listView.mj_header endRefreshing];
            [weakSelf.listView.mj_footer endRefreshing];
            [weakSelf.listView reloadData];
        }
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧按钮点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 设置列表 */
- (void)setListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    __weak typeof(self) weakSelf = self;
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.integerArr = [NSMutableArray array];
        [weakSelf.listView.mj_header beginRefreshing];
        [weakSelf requestIntegerDetail];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf.listView.mj_footer beginRefreshing];
        [weakSelf requestIntegerDetail];
    }];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerNib:[UINib nibWithNibName:@"KGIntegralTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGIntegralTableViewCell"];
    [self.view addSubview:self.listView];
}
/** UITableViewDataSource */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.integerArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGIntegralTableViewCell"];
    if (!cell) {
        cell = [[KGIntegralTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KGIntegralTableViewCell"];
    }
    if (self.integerArr.count > 0) {
        NSDictionary *dic = self.integerArr[indexPath.row];
        cell.titleLab.text = dic[@"details"];
        cell.scoreLab.text = [NSString stringWithFormat:@"+%@",dic[@"number"]];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",dic[@"createDate"]];
    }
    return cell;
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
