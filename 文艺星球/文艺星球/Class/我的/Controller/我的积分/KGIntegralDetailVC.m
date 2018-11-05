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
    self.view.backgroundColor = KGWhiteColor;
    [self setListView];
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
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerNib:[UINib nibWithNibName:@"KGIntegralTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGIntegralTableViewCell"];
    [self.view addSubview:self.listView];
}
/** UITableViewDataSource */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGIntegralTableViewCell"];
    if (!cell) {
        cell = [[KGIntegralTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KGIntegralTableViewCell"];
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
