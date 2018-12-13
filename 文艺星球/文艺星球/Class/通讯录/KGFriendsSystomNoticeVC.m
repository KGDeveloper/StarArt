//
//  KGFriendsSystomNoticeVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFriendsSystomNoticeVC.h"
#import "KGFriendsSystomNoticeCell.h"

@interface KGFriendsSystomNoticeVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation KGFriendsSystomNoticeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    self.title = @"系统通知";
    self.view.backgroundColor = KGWhiteColor;
    
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.listView.bounces = NO;
    [self.view addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGFriendsSystomNoticeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGFriendsSystomNoticeCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGFriendsSystomNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFriendsSystomNoticeCell" forIndexPath:indexPath];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *dateNow = [NSDate date];
    NSString *dateString = [formatter stringFromDate:dateNow];
    cell.timeLab.text = dateString;
    cell.detailLab.text = @"欢迎使用文艺星球官方App，目前暂无系统消息";
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
