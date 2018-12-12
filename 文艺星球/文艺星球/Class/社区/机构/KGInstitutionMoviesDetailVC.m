//
//  KGInstitutionMoviesDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionMoviesDetailVC.h"
#import "KGInstitutionMoviesDetailCell.h"

@interface KGInstitutionMoviesDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
/** 列表头视图 */
@property (nonatomic,strong) UIView *listHeaderView;
/** 顶部封面 */
@property (nonatomic,strong) UIImageView *backImageView;
/** 地址 */
@property (nonatomic,strong) UILabel *addressLab;
/** 电话 */
@property (nonatomic,strong) UILabel *telphoneLab;
/** 时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLab;
/** 相关 */
@property (nonatomic,copy) NSArray *dataArr;
@property (nonatomic,copy) NSDictionary *detailDic;


@end

@implementation KGInstitutionMoviesDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectMake(15, 0, 50, 30) title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    self.title = @"万达影城（望京店）";
    
    [self requestData];
    [self setUpListView];
}
/** 请求详情 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectCommunityPlaceByID parameters:@{@"id":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.detailDic = result[@"data"];
            weakSelf.dataArr = weakSelf.detailDic[@"relatedList"];
            [weakSelf changeUIData];
        }
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/** 列表头 */
- (UIView *)setupHeaderView{
    self.listHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/750*480 + 160)];
    self.listHeaderView.backgroundColor = KGWhiteColor;
    
    UIImageView *locationIcon = [UIImageView new];
    UIImageView *phoneIcon = [UIImageView new];
    UIImageView *timeIcon = [UIImageView new];
    self.backImageView = [UIImageView new];
    self.telphoneLab = [UILabel new];
    self.timeLab = [UILabel new];
    self.addressLab = [UILabel new];
    UIView *topLine = [UIView new];
    self.titleLab = [UILabel new];
    UIView *lowLine = [UIView new];
    
    [self.listHeaderView sd_addSubviews:@[locationIcon,phoneIcon,timeIcon,self.addressLab,self.backImageView,self.telphoneLab,self.timeLab,topLine,self.titleLab,lowLine]];
    
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.layer.masksToBounds = YES;
    self.backImageView.sd_layout
    .leftEqualToView(self.listHeaderView)
    .topEqualToView(self.listHeaderView)
    .rightEqualToView(self.listHeaderView)
    .heightIs(KGScreenWidth/750*480);
    
    locationIcon.image = [UIImage imageNamed:@"定位"];
    locationIcon.sd_layout
    .leftSpaceToView(self.listHeaderView, 15)
    .topSpaceToView(self.backImageView, 15)
    .widthIs(15)
    .heightIs(15);
    phoneIcon.image = [UIImage imageNamed:@"电话"];
    phoneIcon.sd_layout
    .leftSpaceToView(self.listHeaderView, 15)
    .topSpaceToView(locationIcon, 12)
    .widthIs(15)
    .heightIs(15);
    timeIcon.image = [UIImage imageNamed:@"时间"];
    timeIcon.sd_layout
    .leftSpaceToView(self.listHeaderView, 12)
    .topSpaceToView(phoneIcon, 15)
    .widthIs(15)
    .heightIs(15);
    
    self.addressLab.textColor = KGBlackColor;
    self.addressLab.font = KGFontSHRegular(13);
    self.addressLab.sd_layout
    .leftSpaceToView(locationIcon, 15)
    .rightSpaceToView(self.listHeaderView, 15)
    .centerYEqualToView(locationIcon)
    .heightIs(13);
    self.telphoneLab.textColor = KGBlackColor;
    self.telphoneLab.font = KGFontSHRegular(13);
    self.telphoneLab.sd_layout
    .leftSpaceToView(phoneIcon, 15)
    .rightSpaceToView(self.listHeaderView, 15)
    .centerYEqualToView(phoneIcon)
    .heightIs(13);
    self.timeLab.textColor = KGBlackColor;
    self.timeLab.font = KGFontSHRegular(13);
    self.timeLab.sd_layout
    .leftSpaceToView(timeIcon, 15)
    .rightSpaceToView(self.listHeaderView, 15)
    .centerYEqualToView(timeIcon)
    .heightIs(13);
    
    topLine.backgroundColor = KGLineColor;
    topLine.sd_layout
    .leftEqualToView(self.listHeaderView)
    .rightEqualToView(self.listHeaderView)
    .topSpaceToView(timeIcon, 15)
    .heightIs(10);
    
    self.titleLab.textColor = KGBlueColor;
    self.titleLab.font = KGFontSHBold(14);
    self.titleLab.sd_layout
    .leftSpaceToView(self.listHeaderView, 15)
    .rightSpaceToView(self.listHeaderView, 15)
    .topSpaceToView(topLine, 0)
    .heightIs(50);
    
    lowLine.backgroundColor = KGLineColor;
    lowLine.sd_layout
    .leftEqualToView(self.listHeaderView)
    .rightEqualToView(self.listHeaderView)
    .topSpaceToView(self.titleLab, 0)
    .heightIs(1);
    
    return self.listHeaderView;
}
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setupHeaderView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGInstitutionMoviesDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGInstitutionMoviesDetailCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGInstitutionMoviesDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGInstitutionMoviesDetailCell"];
    if (self.dataArr.count > 0) {
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/** 填充数据 */
- (void)changeUIData{
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[self.detailDic[@"image"] componentsSeparatedByString:@"#"] firstObject]]];
    self.title = self.detailDic[@"username"];
    self.addressLab.text = self.detailDic[@"address"];
    self.telphoneLab.text = self.detailDic[@"telphone"];
    self.timeLab.text = self.detailDic[@"potime"];
    if ([self.detailDic[@"type"] integerValue] == 7 || [self.detailDic[@"type"] integerValue] == 8 || [self.detailDic[@"type"] integerValue] == 9 || [self.detailDic[@"type"] integerValue] == 10 || [self.detailDic[@"type"] integerValue] == 11) {
        self.titleLab.text = [NSString stringWithFormat:@"美食(%lu)",(unsigned long)self.dataArr.count];
    }else if ([self.detailDic[@"type"] integerValue] == 2 ){
        self.titleLab.text = [NSString stringWithFormat:@"音乐(%lu)",(unsigned long)self.dataArr.count];
    }else if ([self.detailDic[@"type"] integerValue] == 12){
        self.titleLab.text = [NSString stringWithFormat:@"电影(%lu)",(unsigned long)self.dataArr.count];
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
