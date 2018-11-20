//
//  KGArtisticPeopleDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGArtisticPeopleDetailVC.h"
#import "KGArtisticPeopleDetailTheEndCell.h"
#import "KGArtisticPeopleDetailHomeHeaderView.h"

@interface KGArtisticPeopleDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 首页 */
@property (weak, nonatomic) IBOutlet UIButton *homeBtu;
/** 展讯 */
@property (weak, nonatomic) IBOutlet UIButton *spreadtrumBtu;
/** 作品 */
@property (weak, nonatomic) IBOutlet UIButton *worksBtu;
/** 文章 */
@property (weak, nonatomic) IBOutlet UIButton *articleBtu;
/** 移动直线 */
@property (weak, nonatomic) IBOutlet UIView *moveLine;
/** 移动线位置 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moveLineCenterX;
/** 首页列表 */
@property (nonatomic,strong) UITableView *listView;

@end

@implementation KGArtisticPeopleDetailVC

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
    
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)homeAction:(UIButton *)sender {
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.spreadtrumBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.worksBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.articleBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLineCenterX.constant = self.homeBtu.center.x - KGScreenWidth/8;
    }];
}
- (IBAction)spreadtrumAction:(UIButton *)sender {
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.homeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.worksBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.articleBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLineCenterX.constant = self.spreadtrumBtu.center.x - KGScreenWidth/8;
    }];
}
- (IBAction)worksAction:(UIButton *)sender {
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.spreadtrumBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.homeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.articleBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLineCenterX.constant = self.worksBtu.center.x - KGScreenWidth/8;
    }];
}
- (IBAction)articleAction:(UIButton *)sender {
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.spreadtrumBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.worksBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [self.homeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.moveLineCenterX.constant = self.articleBtu.center.x - KGScreenWidth/8;
    }];
}
/** 列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 50, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 50)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.bounces = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGArtisticPeopleDetailTheEndCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGArtisticPeopleDetailTheEndCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGArtisticPeopleDetailHomeHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"KGArtisticPeopleDetailHomeHeaderView"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
/** 代理方法以及数据源 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGArtisticPeopleDetailTheEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGArtisticPeopleDetailTheEndCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KGArtisticPeopleDetailHomeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KGArtisticPeopleDetailHomeHeaderView"];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 900;
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
