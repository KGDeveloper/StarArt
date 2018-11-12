//
//  KGWhereTheCityOfTheCityVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWhereTheCityOfTheCityVC.h"
#import "KGFoundInterestAreaCell.h"

@interface KGWhereTheCityOfTheCityVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,assign) NSInteger chooseRow;
@property (nonatomic,copy) NSString *cityStr;

@end

@implementation KGWhereTheCityOfTheCityVC

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
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"所在城市";
    self.view.backgroundColor = KGWhiteColor;
    
    self.titleArr = [NSMutableArray arrayWithArray:@[@"北京市",@"西安市",@"成都市",@"上海市",@"天津市",@"广州市",@"深圳市"]];
    self.cityStr = @"北京市";
    self.chooseRow = 0;
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendChooseCity) {
        self.sendChooseCity(self.cityStr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 选择项 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0,KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.backgroundColor = KGWhiteColor;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGFoundInterestAreaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGFoundInterestAreaCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGFoundInterestAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFoundInterestAreaCell" forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.row];
    if (indexPath.row == self.chooseRow) {
        cell.chooseBtu.hidden = NO;
        cell.titleLab.textColor = KGBlueColor;
    }else{
        cell.chooseBtu.hidden = YES;
        cell.titleLab.textColor = KGGrayColor;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.chooseRow = indexPath.row;
    [self.listView reloadData];
    self.cityStr = self.titleArr[indexPath.row];
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
