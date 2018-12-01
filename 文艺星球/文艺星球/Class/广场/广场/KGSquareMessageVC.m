//
//  KGSquareMessageVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSquareMessageVC.h"
#import "KGSquareMessageCell.h"

@interface KGSquareMessageVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 显示消息 */
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGSquareMessageVC

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
    /** 定制右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"qingkong"] font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"消息";
    self.view.backgroundColor = KGWhiteColor;
    self.dataArr = [NSMutableArray array];
    [self requestList];
    [self setUpListView];
}
/** 请求消息列表 */
- (void)requestList{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:ListInform parameters:@{@"pageSize":@"20",@"pageIndex":@"1",} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView reloadData];
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    [self alertView];
}
/** 消息列表 */
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
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGSquareMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSquareMessageCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
/** 代理 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGSquareMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareMessageCell"];
    if (indexPath.row < self.msgCount) {
        cell.contextLab.textColor = KGBlackColor;
    }else{
        cell.contextLab.textColor = KGGrayColor;
    }
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        if ([dic[@"type"] integerValue] == 0) {
            cell.contextLab.text = [NSString stringWithFormat:@"%@给你点赞",dic[@"comName"]];
        }else{
            cell.contextLab.text = [NSString stringWithFormat:@"%@评论你%@",dic[@"comName"],dic[@"content"]];
        }
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"comPortraitUri"]]];
        [cell.customImage sd_setImageWithURL:[NSURL URLWithString:dic[@"rfmImg"]]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)alertView{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"清空所有消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [KGRequest postWithUrl:DeleteInform parameters:@{} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                weakSelf.dataArr = [NSMutableArray array];
                [[KGHUD showMessage:@"清除成功"] hideAnimated:YES afterDelay:1];
            }else{
                [[KGHUD showMessage:@"清除失败"] hideAnimated:YES afterDelay:1];
            }
            [weakSelf.listView reloadData];
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"清除失败"] hideAnimated:YES afterDelay:1];
            [weakSelf.listView reloadData];
        }];
    }];
    [clearAction setValuesForKeysWithDictionary:@{@"titleTextColor":[UIColor colorWithHexString:@"#ff6666"]}];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValuesForKeysWithDictionary:@{@"titleTextColor":[UIColor colorWithHexString:@"#333333"]}];
    
    [alert addAction:clearAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
