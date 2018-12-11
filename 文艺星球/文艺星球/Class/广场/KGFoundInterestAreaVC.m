//
//  KGFoundInterestAreaVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFoundInterestAreaVC.h"
#import "KGFoundInterestAreaCell.h"
#import "KGFoundCell.h"
#import "KGFoundDetailVC.h"

@interface KGFoundInterestAreaVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 地点展示 */
@property (nonatomic,strong) UITableView *listView;
/** 筛选 */
@property (nonatomic,strong) UITableView *screenView;
/** 左侧品类筛选 */
@property (nonatomic,strong) UIButton *classBtu;
/** 右侧排序筛选 */
@property (nonatomic,strong) UIButton *sortBtu;
/** 筛选条件 */
@property (nonatomic,strong) NSMutableArray *screenArr;
/** 选择标签 */
@property (nonatomic,assign) NSInteger selectIndexRow;
/** 品类选择 */
@property (nonatomic,copy) NSString *classString;
/** 排序选择 */
@property (nonatomic,copy) NSString *sortString;
/** 是否是品类选择 */
@property (nonatomic,assign) BOOL isLeft;
/** 好去处 */
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger leftPage;
@property (nonatomic,assign) NSInteger rightPage;

@end

@implementation KGFoundInterestAreaVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 导航栏标题 */
    self.title = @"发现好去处";
    self.view.backgroundColor = KGWhiteColor;
    self.screenArr = [NSMutableArray array];
    self.isLeft = YES;
    self.dataArr = [NSMutableArray array];
    self.page = 1;
    self.leftPage = 0;
    self.rightPage = 0;
    
    [self requestData];
    [self setUpListView];
    [self setUpScreeningView];
}
/** 请求数据 */
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    [[KGRequest shareInstance] requestYourLocation:^(CLLocationCoordinate2D location) {
        [weakSelf requestWithLocation:location];
    }];
    
}
/** 请求 */
- (void)requestWithLocation:(CLLocationCoordinate2D)location{
    __weak typeof(self) weakSelf = self;
    weakSelf.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequest postWithUrl:FindAllGoodPlace parameters:@{@"pageIndex":@(self.page),@"type":@(self.leftPage),@"condition":@(self.rightPage),@"latitude":[NSNumber numberWithDouble:location.latitude],@"longitude":[NSNumber numberWithDouble:location.longitude]} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
        [weakSelf.hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [weakSelf.listView reloadData];
        [weakSelf.hud hideAnimated:YES];
    }];
}
/** 创建显示列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setHeaderView];
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
        weakSelf.page ++;
        [weakSelf requestData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGFoundCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGFoundCell"];
}
/** 创建头部筛选 */
- (UIView *)setHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 40)];
    /** 顶部线 */
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 1)];
    topLine.backgroundColor = KGLineColor;
    [headerView addSubview:topLine];
    /** 品类筛选 */
    self.classBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.classBtu.frame = CGRectMake(0, 0, KGScreenWidth/2, 40);
    [self.classBtu setTitle:@"品类" forState:UIControlStateNormal];
    [self.classBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.classBtu setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
    self.classBtu.titleLabel.font = KGFontSHRegular(14);
    self.classBtu.titleEdgeInsets = UIEdgeInsetsMake(0,-self.classBtu.imageView.bounds.size.width, 0, 0);
    self.classBtu.imageEdgeInsets = UIEdgeInsetsMake(0, self.classBtu.titleLabel.bounds.size.width + 40, 0, 0);
    [self.classBtu addTarget:self action:@selector(classAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.classBtu];
    /** 排序筛选 */
    self.sortBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sortBtu.frame = CGRectMake(KGScreenWidth/2, 0, KGScreenWidth/2, 40);
    [self.sortBtu setTitle:@"排序" forState:UIControlStateNormal];
    [self.sortBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.sortBtu setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
    self.sortBtu.titleLabel.font = KGFontSHRegular(14);
    self.sortBtu.titleEdgeInsets = UIEdgeInsetsMake(0,-self.sortBtu.imageView.bounds.size.width, 0, 0);
    self.sortBtu.imageEdgeInsets = UIEdgeInsetsMake(0, self.sortBtu.titleLabel.bounds.size.width + 40, 0, 0);
    [self.sortBtu addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.sortBtu];
    /** 低部线 */
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39, KGScreenWidth, 1)];
    lowLine.backgroundColor = KGLineColor;
    [headerView addSubview:lowLine];
    return headerView;
}
/** 品类筛选点击事件 */
- (void)classAction:(UIButton *)sender{
    if ([sender.currentTitleColor isEqual:KGBlueColor]) {
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
        self.screenView.hidden = YES;
    }else{
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"quancheng"] forState:UIControlStateNormal];
        [self.sortBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [self.sortBtu setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
        self.isLeft = YES;
        self.screenView.hidden = NO;
        self.screenArr = [NSMutableArray arrayWithArray:@[@"餐厅",@"咖啡",@"茗茶",@"糕点面包",@"酒店民宿",@"书店",@"夜蒲",@"影像音乐",@"展览艺术",@"花店",@"度假胜地",@"集成店",@"剧院"]];
        [self.screenView reloadData];
    }
}
/** 排序筛选点击事件 */
- (void)sortAction:(UIButton *)sender{
    if ([sender.currentTitleColor isEqual:KGBlueColor]) {
        [sender setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
        self.screenView.hidden = YES;
    }else{
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"quancheng"] forState:UIControlStateNormal];
        [self.classBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [self.classBtu setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
        self.isLeft = YES;
        self.screenView.hidden = NO;
        self.screenArr = [NSMutableArray arrayWithArray:@[@"离我最近",@"人均最低",@"人均最高"]];
        [self.screenView reloadData];
    }
}
/** 筛选view */
- (void)setUpScreeningView{
    self.screenView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 40, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 40)];
    self.screenView.delegate = self;
    self.screenView.dataSource = self;
    self.screenView.hidden = YES;
    self.screenView.scrollEnabled = YES;
    self.screenView.bounces = NO;
    self.screenView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
    self.screenView.tableFooterView = [UIView new];
    self.screenView.showsVerticalScrollIndicator = NO;
    self.screenView.showsHorizontalScrollIndicator = NO;
    self.screenView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view insertSubview:self.screenView atIndex:99];
    
    [self.screenView registerNib:[UINib nibWithNibName:@"KGFoundInterestAreaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGFoundInterestAreaCell"];
}
/** 代理 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.listView) {
        return self.dataArr.count;
    }else{
        return self.screenArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.listView) {
        return KGScreenWidth/750*332 + 170;
    }else{
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.listView) {
        KGFoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFoundCell"];
        if (self.dataArr.count > 0) {
            NSDictionary *dic = self.dataArr[indexPath.row];
            [cell sendModelToCell:dic];
        }
        return cell;
    }else{
        KGFoundInterestAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFoundInterestAreaCell"];
        if (self.selectIndexRow == indexPath.row) {
            cell.chooseBtu.hidden = NO;
            cell.titleLab.textColor = KGBlueColor;
        }else{
            cell.chooseBtu.hidden = YES;
            cell.titleLab.textColor = KGBlackColor;
        }
        if (self.screenArr.count > 0) {
            cell.titleLab.text = self.screenArr[indexPath.row];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.listView) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        KGFoundDetailVC *vc = [[KGFoundDetailVC alloc]init];
        vc.detailId = dic[@"id"];
        [self pushHideenTabbarViewController:vc animted:YES];
    }else{
        self.selectIndexRow = indexPath.row;
        [self.screenView reloadData];
        if (self.isLeft == YES) {
            self.leftPage = indexPath.row;
        }else{
            self.rightPage = indexPath.row;
        }
        self.screenView.hidden = YES;
        [self.classBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [self.sortBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [self.classBtu setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
        [self.sortBtu setImage:[UIImage imageNamed:@"liwozuijin"] forState:UIControlStateNormal];
        [self.listView.mj_header beginRefreshing];
    }
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"404"];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"可能因为网络原因加载失败，请点击刷新";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    // 设置按钮标题
    NSString *buttonTitle = @"重新加载";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName:KGBlueColor
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self.listView.mj_header beginRefreshing];
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
