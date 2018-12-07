//
//  KGInstitutionHotDramaVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionHotDramaVC.h"
#import "KGInstitutionHotDramaCell.h"
#import "KGInstitutionDramaTheUpcomingVC.h"
#import "KGInstitutionDramaDetailVC.h"

@interface KGInstitutionHotDramaVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
/** 导航左侧 */
@property (nonatomic,strong) UIButton *leftBtu;
/** 导航右侧 */
@property (nonatomic,strong) UIButton *rightBtu;
/** 即将上映 */
@property (nonatomic,strong) KGInstitutionDramaTheUpcomingVC *upcomingVC;
/** 页码 */
@property (nonatomic,assign) NSInteger page;
/** 近期热门 */
@property (nonatomic,copy) NSString *navigationStr;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGInstitutionHotDramaVC

/** 即将上映 */
- (KGInstitutionDramaTheUpcomingVC *)upcomingVC{
    if (!_upcomingVC) {
        _upcomingVC = [[KGInstitutionDramaTheUpcomingVC alloc]init];
        [self addChildViewController:_upcomingVC];
    }
    return _upcomingVC;
}
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
    self.title = @"近期热门";
    self.view.backgroundColor = KGAreaGrayColor;
    self.page = 1;
    self.navigationStr = @"近期热门";
    self.dataArr = [NSMutableArray array];
    [self setUpListView];
    [self setNavCenterView];
}
/** 请求数据 */
- (void)requestData{
    NSString *cityId = nil;
    if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"北京市"]) {
        cityId = @"1";
    }else if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"天津市"]){
        cityId = @"43";
    }else if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"西安市"]){
        cityId = @"54";
    }else if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"广州市"]){
        cityId = @"28";
    }else if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"成都市"]){
        cityId = @"65";
    }else if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"上海市"]){
        cityId = @"13";
    }else if ([[KGRequest shareInstance].userLocationCity isEqualToString:@"深圳市"]){
        cityId = @"36";
    }else{
        cityId = @"1";
    }
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
/** 导航栏设置 */
- (void)setNavCenterView{
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.navigationItem.titleView = centerView;
    
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtu.frame = CGRectMake(0, 0, 100, 30);
    [self.leftBtu setTitle:@"近期热门" forState:UIControlStateNormal];
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.leftBtu.titleLabel.font = KGFontSHBold(15);
    [self.leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:self.leftBtu];
    
    self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtu.frame = CGRectMake(100, 0, 100, 30);
    [self.rightBtu setTitle:@"即将上映" forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.rightBtu.titleLabel.font = KGFontSHBold(15);
    [self.rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:self.rightBtu];
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 左侧按钮 */
- (void)leftAction:(UIButton *)leftBtu{
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.upcomingVC.view removeFromSuperview];
    self.navigationStr = @"近期热门";
}
/** 右侧按钮 */
- (void)rightAction:(UIButton *)leftBtu{
    [self.leftBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.upcomingVC.view];
    self.navigationStr = @"即将上映";
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
