//
//  KGNewsDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNewsDetailVC.h"
#import "KGNewsDetailUIImageViewCell.h"
#import "KGNewsDetailUILabCell.h"
#import "KGAgencyDetailTableViewCell.h"

@interface KGNewsDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 图书列表 */
@property (nonatomic,strong) UITableView *listView;

@end

@implementation KGNewsDetailVC

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
// MARK: --创建机构列表--
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
    [self.view addSubview:self.listView];
    
    [self.listView registerClass:[KGNewsDetailUILabCell class] forCellReuseIdentifier:@"KGNewsDetailUILabCell"];
    [self.listView registerClass:[KGNewsDetailUIImageViewCell class] forCellReuseIdentifier:@"KGNewsDetailUIImageViewCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGAgencyDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyDetailTableViewCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
/** 代理方法以及数据源 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:KGScreenWidth tableView:self.listView];
        return 70;
    }else{
        return 120;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row%2==0) {
            KGNewsDetailUILabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUILabCell"];
            return cell;
        }else{
            KGNewsDetailUIImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUIImageViewCell"];
            return cell;
        }
    }else{
        KGAgencyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailTableViewCell"];
        return cell;
    }
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
