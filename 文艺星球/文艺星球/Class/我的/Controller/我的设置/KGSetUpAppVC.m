//
//  KGSetUpAppVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSetUpAppVC.h"
#import "KGSetupCell.h"
#import "KGSetUpAdviceVC.h"
#import "KGAboutOurVC.h"
#import "KGLoginVC.h"
#import "AppDelegate.h"

@interface KGSetUpAppVC ()<UITableViewDelegate,UITableViewDataSource>
/** 登录积分详情 */
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *dataArr;

@end

@implementation KGSetUpAppVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHRegular(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"设置";
    self.view.backgroundColor = KGAreaGrayColor;
    self.dataArr = @[@"意见反馈",@"关于我们",[NSString stringWithFormat:@"版本%@",[KGUserInfo shareInstance].app_Version],@"退出当前账号"];
    [self setListView];
}
/** 导航栏左侧按钮点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 设置列表 */
- (void)setListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, 240)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.scrollEnabled = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerNib:[UINib nibWithNibName:@"KGSetupCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSetupCell"];
    [self.view addSubview:self.listView];
}
/** UITableViewDataSource */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGSetupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSetupCell"];
    if (!cell) {
        cell = [[KGSetupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KGSetupCell"];
    }
    if (indexPath.row >= 2) {
        cell.rightImage.hidden = YES;
    }
    cell.titleLab.text = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self pushHideenTabbarViewController:[[KGSetUpAdviceVC alloc]init] animted:YES];
    }else if (indexPath.row == 1){
        [self pushHideenTabbarViewController:[[KGAboutOurVC alloc]init] animted:YES];
    }else if (indexPath.row == 3){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"文艺星球" message:@"你确定退出登录？退出后你无法继续使用文艺星球软件！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *shureAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *windows = [UIApplication sharedApplication].keyWindow;
            windows.rootViewController = [[KGLoginVC alloc]init];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:shureAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
